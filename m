Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5F3C77B72
	for <rcu@archiver.kernel.org>; Fri, 14 Apr 2023 22:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjDNWsF (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Apr 2023 18:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDNWsE (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Apr 2023 18:48:04 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660FD65B7
        for <rcu@vger.kernel.org>; Fri, 14 Apr 2023 15:48:03 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id p17so8736751pla.3
        for <rcu@vger.kernel.org>; Fri, 14 Apr 2023 15:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681512483; x=1684104483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJb0KwyXKGfY6mX8iGwWEkANBxogm40HVAQYrOTtu0c=;
        b=N7HzkyzKZ5h++hraUltULP16++S6GjGJxoPdzrZmbUFL9Y9wGcIQAb+Rn40rdJLGsV
         Ld4F/yuujEe2lTK/QqJw+wDPgJBtg7gpoSodkLV+D2RucCE3HT7m/J8R1ztRBnowq2HM
         Jtng1CISorVdK5LczBcrsNhoXsHDtDcVzNhpNkcpj/fhL4918QmpDhCYT1I+HIBWw8Fc
         Eupn+7BlXVhEC7R9Nx2fsoWt+ay4pQsAdx3uk1CkNFSg0FAGIknBU/TESkc91LS+8ThD
         ndgFshQESCYvepH+luh1dpWeXZjcnRdblSQihoSKbph+2M3zMcIGbFuCf9JfwOeAA8Dq
         134A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681512483; x=1684104483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YJb0KwyXKGfY6mX8iGwWEkANBxogm40HVAQYrOTtu0c=;
        b=kXEulwd1OkG9KC4jVk17Au8AMNcAzoVcV8a/DQ3+y39NhQZFWDs5pbQf12Je62Qm2I
         eYjwiUKZiZw2SU3dgM4OFFj9670ikPlS2RgkHQL7LOJOHJcezixI7lvQZA3Cn+6dX6Ce
         ugWq6uGq+AEzfJTgf9IsA4GJrmhRSKEz8DY8PpTk4vTvockCsz15wIBrZK9+cQE2WxN1
         5dI41Ilf4RMGwsJeAtt+GcyfNx8UhjzM5/hPVarzjK/z3/rEuFeXDGqOoMyxihCvmX8I
         nuTRVAzs4ljLfsXMcPaHsc853PeGLKHYecYfECLIGPVvkKVL5ZkUga+0NCyp+chlSW9C
         gcvA==
X-Gm-Message-State: AAQBX9fx3LPkCSuDTjVOVWKCF2a1/i7mo+ZlRk0FeoEGRXVKU+DmjkQn
        j4tNiuEYzB5MeRUtF9QP8IVYQMeq8BdMG97kTCtObg==
X-Google-Smtp-Source: AKy350bTCIpc2zhRKnkD3Dn0c4AXgW2+siyH8qleETFGjwS99xIJ17dMKKQVqSkS4tzNOrJ7SkULXawOyHjfN6Uudbg=
X-Received: by 2002:a17:90b:108c:b0:247:398c:d64f with SMTP id
 gj12-20020a17090b108c00b00247398cd64fmr3688387pjb.23.1681512482722; Fri, 14
 Apr 2023 15:48:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230414005309.GA2198310@google.com>
In-Reply-To: <20230414005309.GA2198310@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 14 Apr 2023 15:47:51 -0700
Message-ID: <CAKwvOd=yQS+0oDC46Hc5D_V0JET8=xbQmAJrpBdg7c4i2EyqHg@mail.gmail.com>
Subject: Re: clangd cannot handle tree_nocb.h
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, nathan@kernel.org, trix@redhat.com,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Apr 13, 2023 at 5:53=E2=80=AFPM Joel Fernandes <joel@joelfernandes.=
org> wrote:
>
> Hello!
>
> I have been trying to get clangd working properly with tree_nocb.h. clang=
d
> trips quite badly when trying to build tree_nocb.h to generate ASTs.

Hi Joel,
Thanks for the report.  What are you using clangd for? I'll bet
something interesting.

I've never used it myself, so I don't know where to even begin with
how to reproduce the issue.

It might be worth filing a bug upstream at
https://github.com/llvm/llvm-project/issues
or internally under the component
Language Platforms > C++ > Clang > Tools > Clangd
with detailed steps to reproduce (and what the observed error actually
is). Feel free to cc me, though I don't know the first thing about
clangd.

>
> I get something like this in the clangd logs showing it 'infers' how to b=
uild
> tree_nocb.h because it could not find a command in compile_commands.json:
>
> ASTWorker building file [..]/tree_nocb.h version 9 with command inferred =
from
> [..]/kernel/rcu/tree.c
>
> This leads to all hell breaking lose with complaints about missing rcu_da=
ta
> struct definition and so forth.
>
> So far I came up with a workaround as follows, but is there a better way?
>
> 1. Open compile_commands.json and add a new entry as follows, with a
> definition "-DNOCB_H_CLANGD_PARSE". Otherwise the entry is indentical to =
how
> tree.c is built.
>
>   {
>     "arguments": [
>       "/usr/bin/clang",
>       "-Wp,-MMD,kernel/rcu/.treenocb.o.d",
>       "-nostdinc",
>       "-I./arch/x86/include",
>       "-I./arch/x86/include/generated",
>       "-I./include",
>       "-I./arch/x86/include/uapi",
> [...]
>       "-Wformat-zero-length",
>       "-Wnonnull",
>       "-Wformat-insufficient-args",
>       "-Wno-sign-compare",
>       "-Wno-pointer-to-enum-cast",
>       "-Wno-tautological-constant-out-of-range-compare",
>       "-Wno-unaligned-access",
>       "-DKBUILD_MODFILE=3D\"kernel/rcu/tree\"",
>       "-DKBUILD_BASENAME=3D\"tree\"",
>       "-DKBUILD_MODNAME=3D\"tree\"",
>       "-D__KBUILD_MODNAME=3Dkmod_tree",
>       "-DNOCB_H_CLANGD_PARSE",
>       "-c",
>       "-I",
>       "/s/",
>       "-I",
>       "/s/",
>       "-o",
>       "kernel/rcu/tree_nocb.h.o",
>       "kernel/rcu/tree_nocb.h"
>     ],
>     "directory": "/usr/local/google/home/joelaf/repo/linux-master",
>     "file": "/usr/local/google/home/joelaf/repo/linux-master/kernel/rcu/t=
ree_nocb.h",
>     "output": "/usr/local/google/home/joelaf/repo/linux-master/kernel/rcu=
/tree_nocb.h.o"
>   },
>
> 2.
> Then in kernel/tree/tree_nocb.h, I do the following right in the beginnin=
g.
> (Thanks to paulmck@ for this idea).
>
> #ifdef NOCB_H_CLANGD_PARSE
> #include "tree.c"
> #endif
>
> 3. To prevent the above inclusion of tree.c from recursively including
> tree_nocb.h, I do the following at the end of tree.c
>
> +#ifndef NOCB_H_CLANGD_PARSE
>  #include "tree_nocb.h"
> -#include "tree_plugin.h"
> +#endif
> +#include "tree_plugin.h"
>
> With that it works, but if I ever generate compile_commands.json again, t=
hen
> I'll have to again modify compile_commands.json manually to make my edito=
r
> work again with clangd.
>
> So I guess my questions are:
>
> 1. Is there a 'standard' procedure to solve something like this?
>
> 2. How do we fix this the right way?
>    One way would be for scripts/clang-tools/gen_compile_commands.py to pa=
rse
>    header files and generate suitable compile_commands.json based on
>    meta-data in the header file.
>
> 3. How do we fix this for other header files in general? Do we have to ma=
ke hacks like
>    above (sad face) or can we come up with a standard way to make it work=
 for kernel
>    sources?
>
> Thank you!
>
>  - Joel
>
>
>
>
>
>


--=20
Thanks,
~Nick Desaulniers
