Return-Path: <SRS0=7kaP=SM=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB45C10F11
	for <rcu@archiver.kernel.org>; Wed, 10 Apr 2019 17:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA6512082E
	for <rcu@archiver.kernel.org>; Wed, 10 Apr 2019 17:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="dDcJMViz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730168AbfDJRsE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 10 Apr 2019 13:48:04 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34839 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730164AbfDJRsE (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 10 Apr 2019 13:48:04 -0400
Received: by mail-pf1-f193.google.com with SMTP id t21so1930451pfh.2
        for <rcu@vger.kernel.org>; Wed, 10 Apr 2019 10:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sbutHiCZ8mGxfyY9QSUioqjtpuKW2Q5N9kWxngYGrGQ=;
        b=dDcJMVizqpsIxP1GaENl0R/3F7wvMJlKcWI+khcgfVdfGkqvLa3RfggN5bN1CsnMh/
         kJpy17p0XXe6vbOB8d9d6eyDwmIAWBLfM7I0SXPx/pdf40lEkCKCkiWn5pYGqHv3DiXS
         QMVJU5qVKOrKTeQPRze2Hi8xB9JvFOyoorVDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sbutHiCZ8mGxfyY9QSUioqjtpuKW2Q5N9kWxngYGrGQ=;
        b=qaz7XbQTPs2OIHS7OCyrapytW5BHP58jgHZMuZxusjLqI1GzWsbhg9AFLCNc/XcFtL
         N9MwdRZwjvY2M7QOyewec3KI6cot2XDe0mb2o/u7v7LIk1db+i8uDYW/nQk3DHQ2pVcN
         O8MAYZqr6PhElz0adzYv1a/jO3U9yEh8Fs9KeZ0OZbFLuWV85KY+pdGY5a7lrLCRonhN
         W2PPC1q2H/o246t7+HRVVplv4HAQO0TCxmrGaqNN5lEeFzzxLmYgs6r39TrrjB6bDN4U
         jL6FL7QSSgca+8R4xgjfXL59IrnsL5nlStWaNSCd87pLUQ44AYb5E2U6MGU/DYQ23ySz
         9lsg==
X-Gm-Message-State: APjAAAUi64Ir9ORIkGMlkse5MJCA9aBXCo2BVKgKaOonKMxn/DMDk4nZ
        B5tibQhDo8YRkbz25UBWggcKeQ==
X-Google-Smtp-Source: APXvYqxpsrtFwPwC2NMCBJeO4o6A92ulkAQ1biyJqNy6WYgouj9AdzvPIpyrg/tsadDPOXi+vTXCSA==
X-Received: by 2002:a63:e845:: with SMTP id a5mr43320973pgk.246.1554918483038;
        Wed, 10 Apr 2019 10:48:03 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id y20sm32535485pfe.188.2019.04.10.10.48.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Apr 2019 10:48:02 -0700 (PDT)
Date:   Wed, 10 Apr 2019 13:48:00 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Android Kernel Team <kernel-team@android.com>,
        Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH 1/2] module: Prepare for addition of new ro_after_init
 sections
Message-ID: <20190410174800.GA259061@google.com>
References: <20190410011418.76408-1-joel@joelfernandes.org>
 <CAGXu5jKs6Ag2L+GYEVYAzPky1pLntZt-Tc5ki-pqjVoyCWgxxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jKs6Ag2L+GYEVYAzPky1pLntZt-Tc5ki-pqjVoyCWgxxg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Apr 10, 2019 at 09:26:44AM -0700, Kees Cook wrote:
> On Tue, Apr 9, 2019 at 6:14 PM Joel Fernandes (Google)
> <joel@joelfernandes.org> wrote:
> >
> > For the purposes of hardening modules by adding sections to
> > ro_after_init sections, prepare for addition of new ro_after_init
> > entries which we do in future patches. Create a table to which new
> > entries could be added later. This makes it less error prone and reduce
> > code duplication.
> >
> > Cc: paulmck@linux.vnet.ibm.com
> > Cc: rostedt@goodmis.org
> > Cc: mathieu.desnoyers@efficios.com
> > Cc: rcu@vger.kernel.org
> > Cc: kernel-hardening@lists.openwall.com
> > Cc: kernel-team@android.com
> > Suggested-by: keescook@chromium.org
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> >
> > ---
> >  kernel/module.c | 42 ++++++++++++++++++++++++------------------
> >  1 file changed, 24 insertions(+), 18 deletions(-)
> >
> > diff --git a/kernel/module.c b/kernel/module.c
> > index 524da609c884..f9221381d076 100644
> > --- a/kernel/module.c
> > +++ b/kernel/module.c
> > @@ -3300,11 +3300,28 @@ static bool blacklisted(const char *module_name)
> >  }
> >  core_param(module_blacklist, module_blacklist, charp, 0400);
> >
> > +/*
> > + * Mark ro_after_init section with SHF_RO_AFTER_INIT so that
> > + * layout_sections() can put it in the right place.
> > + * Note: ro_after_init sections also have SHF_{WRITE,ALLOC} set.
> > + */
> > +static char *ro_after_init_sections[] = {
> 
> static const char * const ... Need to make sure the table and its
> strings can't be changed. :)

Will fix :)

> > +       ".data..ro_after_init",
> > +
> > +       /*
> > +        * __jump_table structures are never modified, with the exception of
> > +        * entries that refer to code in the __init section, which are
> > +        * annotated as such at module load time.
> > +        */
> > +       "__jump_table",
> > +       NULL
> 
> Since this table is known at build time, you don't need a NULL
> terminator, you can use ARRAY_SIZE() instead.

Ok, sounds good. You are absolutely right.

> > +};
> > +
> >  static struct module *layout_and_allocate(struct load_info *info, int flags)
> >  {
> >         struct module *mod;
> >         unsigned int ndx;
> > -       int err;
> > +       int err, i;
> >
> >         err = check_modinfo(info->mod, info, flags);
> >         if (err)
> > @@ -3319,23 +3336,12 @@ static struct module *layout_and_allocate(struct load_info *info, int flags)
> >         /* We will do a special allocation for per-cpu sections later. */
> >         info->sechdrs[info->index.pcpu].sh_flags &= ~(unsigned long)SHF_ALLOC;
> >
> > -       /*
> > -        * Mark ro_after_init section with SHF_RO_AFTER_INIT so that
> > -        * layout_sections() can put it in the right place.
> > -        * Note: ro_after_init sections also have SHF_{WRITE,ALLOC} set.
> > -        */
> > -       ndx = find_sec(info, ".data..ro_after_init");
> > -       if (ndx)
> > -               info->sechdrs[ndx].sh_flags |= SHF_RO_AFTER_INIT;
> > -       /*
> > -        * Mark the __jump_table section as ro_after_init as well: these data
> > -        * structures are never modified, with the exception of entries that
> > -        * refer to code in the __init section, which are annotated as such
> > -        * at module load time.
> > -        */
> > -       ndx = find_sec(info, "__jump_table");
> > -       if (ndx)
> > -               info->sechdrs[ndx].sh_flags |= SHF_RO_AFTER_INIT;
> > +       /* Set sh_flags for read-only after init sections */
> > +       for (i = 0; ro_after_init_sections[i]; i++) {
> 
> i.e. for (i = 0; i < ARRAY_SIZE(ro_after_init_sections); i++)

Yep.

> > +               ndx = find_sec(info, ro_after_init_sections[i]);
> > +               if (ndx)
> > +                       info->sechdrs[ndx].sh_flags |= SHF_RO_AFTER_INIT;
> > +       }
> >
> >         /* Determine total sizes, and put offsets in sh_entsize.  For now
> >            this is done generically; there doesn't appear to be any
> 
> Otherwise, yeah, looks good to me.

Thanks, if you are Ok with it, I will add your Reviewed-by tag as well.

 - Joel

