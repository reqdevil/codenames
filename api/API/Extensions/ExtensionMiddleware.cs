//using Core.Common;
//using Core.Common.Enums;
//using Microsoft.AspNetCore.Http;
//using Microsoft.IdentityModel.Logging;
//using System;
//using System.Collections.Generic;
//using System.Diagnostics;
//using System.Linq;
//using System.Threading.Tasks;

//namespace API.Extensions
//{
//    public class ExtensionMiddleware
//    {
//        private readonly RequestDelegate _next;
//        public IslemSonucu islemSonucu = new IslemSonucu() { IslemDurumu = IslemDurumu.IslemeHenuzBaslanmadi, Mesaj = string.Empty };

//        public ExceptionMiddleware(RequestDelegate next)
//        {
//            _next = next; 
//        }

//        public async Task InvokeAsync(HttpContext httpContext, IUnitOfWork worker)
//        {
//            _mersisContext = mersisEntities;
//            _exceptionLogRepository = new BaseRepository<EntityModel.Entities.ExceptionLog>(_mersisContext);
//            _worker = worker;

//            try
//            {
//                await _next(httpContext);
//            }
//            catch (AccessViolationException avEx)
//            {
//                await HandleExceptionAsync(httpContext, avEx);
//            }
//            catch (Exception ex)
//            {
//                await HandleExceptionAsync(httpContext, ex);
//            }
//        }
//        private Task HandleExceptionAsync(HttpContext context, Exception ex)
//        {
//            if (ex is ApplicationException)
//            {
//                islemSonucu.IslemDurumu = IslemDurumu.HataNedeniyleTamamlanamadi;
//                islemSonucu.Mesaj = ex.Message;
//            }
//            else
//            {
//                #region Save exception to file system

//                try
//                {
//                    Common.Exceptions.ExceptionHelper.Handle(new StackTrace().GetFrame(0), ex);
//                }
//                catch
//                {
//                }

//                #endregion

//                #region Save exception to database
//                var logObject = LogHelper.CreateExceptionLogObject(new StackTrace().GetFrame(0), ex);
//                islemSonucu.IslemDurumu = IslemDurumu.HataNedeniyleTamamlanamadi;
//                islemSonucu.Mesaj = ex.Message;

//                EntityModel.Entities.ExceptionLog entityToInsert = new EntityModel.Entities.ExceptionLog()
//                {
//                    IpAddress = logObject.IpAddress,
//                    IslemTarihi = logObject.IslemTarihi,
//                    KullaniciId = logObject.KullaniciId,
//                    Method = logObject.Method,
//                    Type = logObject.Type,
//                    Exception = logObject.Exception,
//                    StackTrace = logObject.StackTrace
//                };
//                _exceptionLogRepository.Insert(entityToInsert);
//                _worker.Save();
//                #endregion

//                #region Create and return standart error message
//            }


//            context.Response.ContentType = "application/json";
//            context.Response.StatusCode = (int)IslemDurumu.HataNedeniyleTamamlanamadi;

//            return context.Response.WriteAsync(new IslemSonucu()
//            {
//                IslemDurumu = islemSonucu.IslemDurumu,
//                Mesaj = islemSonucu.Mesaj
//            }.ToString());

//            #endregion
//        }
//    }
//}
