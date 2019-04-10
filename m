Return-Path: <SRS0=7kaP=SM=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3269FC10F11
	for <rcu@archiver.kernel.org>; Wed, 10 Apr 2019 16:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F35E820830
	for <rcu@archiver.kernel.org>; Wed, 10 Apr 2019 16:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E9gnJVUt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731073AbfDJQ06 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:26:58 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:41349 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730614AbfDJQ06 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 10 Apr 2019 12:26:58 -0400
Received: by mail-vs1-f65.google.com with SMTP id g187so1716703vsc.8
        for <rcu@vger.kernel.org>; Wed, 10 Apr 2019 09:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RGqWd5s2z6twzy3qMbCU3gfqqHA/VTihRqe1wZ4RTtA=;
        b=E9gnJVUtMzsmf5rEACunC74b4NvUmMxRKKstD0MEOfGYfSWUcIWFiJSPJnbwfbjOFc
         aD0o75AWKlg92da2NVPisryx8XdC4Vw9m04sdHyZOWMED4/lmbb2aoKxZO3LSjElsXW/
         E4Z0lg6C2FfGLHAdisUsa8OiwULoAiSLtmSws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RGqWd5s2z6twzy3qMbCU3gfqqHA/VTihRqe1wZ4RTtA=;
        b=IrIy2UW2mAUSTJ1s2lZyzFK6zBJ6P9NKOWXd6b1l23YhFwv5NYbONdj5wjKJVKTmhd
         GITAH1YFC96ybeAve/aYrtU7kGBA0AnqNUavOt0guVZmbNLk3zG/yWZcjlniWS4LVKLs
         SPzkav11CkH8quBAXRmGI/tzFP8Vr5jWa1ni/+n0ErV2FhPYLu+QZil2H12v4r3Pj3An
         FAGdYtaE6qldn61xaIGWiA2wuCjXMlCwhHEjGkCwxQCNY8nEcQ7CBzHD5fsQKdaM29C8
         FUrFXh3uF9XwjYbYJ7isZyk22jcENl9ShR5rSNHk1zKZuXQA9pl9f7KxXP911MZlQMqV
         wt0w==
X-Gm-Message-State: APjAAAX6Vx/5poxNfX9PswXVXwfaKEhKOv9XUKK5Kdnwueb6aG1ddMRH
        OnZs1U94aLaqB2pNOnz+nGq5LT/ZwDI=
X-Google-Smtp-Source: APXvYqzmddlXY745KGdE8R3eQvREiEAuS3BbsuwJfGAtfRvmPuVU7eGxb4QKYGUYOT5m70pC52lhcA==
X-Received: by 2002:a67:8010:: with SMTP id b16mr25039450vsd.189.1554913617215;
        Wed, 10 Apr 2019 09:26:57 -0700 (PDT)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id j71sm28343408vsd.0.2019.04.10.09.26.56
        for <rcu@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 09:26:56 -0700 (PDT)
Received: by mail-ua1-f53.google.com with SMTP id d5so986984uan.6
        for <rcu@vger.kernel.org>; Wed, 10 Apr 2019 09:26:56 -0700 (PDT)
X-Received: by 2002:ab0:4eaa:: with SMTP id l42mr18185593uah.80.1554913615771;
 Wed, 10 Apr 2019 09:26:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190410011418.76408-1-joel@joelfernandes.org>
In-Reply-To: <20190410011418.76408-1-joel@joelfernandes.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 10 Apr 2019 09:26:44 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKs6Ag2L+GYEVYAzPky1pLntZt-Tc5ki-pqjVoyCWgxxg@mail.gmail.com>
Message-ID: <CAGXu5jKs6Ag2L+GYEVYAzPky1pLntZt-Tc5ki-pqjVoyCWgxxg@mail.gmail.com>
Subject: Re: [PATCH 1/2] module: Prepare for addition of new ro_after_init sections
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Android Kernel Team <kernel-team@android.com>,
        Kees Cook <keescook@chromium.org>, Jessica Yu <jeyu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Apr 9, 2019 at 6:14 PM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> For the purposes of hardening modules by adding sections to
> ro_after_init sections, prepare for addition of new ro_after_init
> entries which we do in future patches. Create a table to which new
> entries could be added later. This makes it less error prone and reduce
> code duplication.
>
> Cc: paulmck@linux.vnet.ibm.com
> Cc: rostedt@goodmis.org
> Cc: mathieu.desnoyers@efficios.com
> Cc: rcu@vger.kernel.org
> Cc: kernel-hardening@lists.openwall.com
> Cc: kernel-team@android.com
> Suggested-by: keescook@chromium.org
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>
> ---
>  kernel/module.c | 42 ++++++++++++++++++++++++------------------
>  1 file changed, 24 insertions(+), 18 deletions(-)
>
> diff --git a/kernel/module.c b/kernel/module.c
> index 524da609c884..f9221381d076 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -3300,11 +3300,28 @@ static bool blacklisted(const char *module_name)
>  }
>  core_param(module_blacklist, module_blacklist, charp, 0400);
>
> +/*
> + * Mark ro_after_init section with SHF_RO_AFTER_INIT so that
> + * layout_sections() can put it in the right place.
> + * Note: ro_after_init sections also have SHF_{WRITE,ALLOC} set.
> + */
> +static char *ro_after_init_sections[] = {

static const char * const ... Need to make sure the table and its
strings can't be changed. :)

> +       ".data..ro_after_init",
> +
> +       /*
> +        * __jump_table structures are never modified, with the exception of
> +        * entries that refer to code in the __init section, which are
> +        * annotated as such at module load time.
> +        */
> +       "__jump_table",
> +       NULL

Since this table is known at build time, you don't need a NULL
terminator, you can use ARRAY_SIZE() instead.

> +};
> +
>  static struct module *layout_and_allocate(struct load_info *info, int flags)
>  {
>         struct module *mod;
>         unsigned int ndx;
> -       int err;
> +       int err, i;
>
>         err = check_modinfo(info->mod, info, flags);
>         if (err)
> @@ -3319,23 +3336,12 @@ static struct module *layout_and_allocate(struct load_info *info, int flags)
>         /* We will do a special allocation for per-cpu sections later. */
>         info->sechdrs[info->index.pcpu].sh_flags &= ~(unsigned long)SHF_ALLOC;
>
> -       /*
> -        * Mark ro_after_init section with SHF_RO_AFTER_INIT so that
> -        * layout_sections() can put it in the right place.
> -        * Note: ro_after_init sections also have SHF_{WRITE,ALLOC} set.
> -        */
> -       ndx = find_sec(info, ".data..ro_after_init");
> -       if (ndx)
> -               info->sechdrs[ndx].sh_flags |= SHF_RO_AFTER_INIT;
> -       /*
> -        * Mark the __jump_table section as ro_after_init as well: these data
> -        * structures are never modified, with the exception of entries that
> -        * refer to code in the __init section, which are annotated as such
> -        * at module load time.
> -        */
> -       ndx = find_sec(info, "__jump_table");
> -       if (ndx)
> -               info->sechdrs[ndx].sh_flags |= SHF_RO_AFTER_INIT;
> +       /* Set sh_flags for read-only after init sections */
> +       for (i = 0; ro_after_init_sections[i]; i++) {

i.e. for (i = 0; i < ARRAY_SIZE(ro_after_init_sections); i++)

> +               ndx = find_sec(info, ro_after_init_sections[i]);
> +               if (ndx)
> +                       info->sechdrs[ndx].sh_flags |= SHF_RO_AFTER_INIT;
> +       }
>
>         /* Determine total sizes, and put offsets in sh_entsize.  For now
>            this is done generically; there doesn't appear to be any

Otherwise, yeah, looks good to me.

-- 
Kees Cook
