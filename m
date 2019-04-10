Return-Path: <SRS0=7kaP=SM=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FF0C10F11
	for <rcu@archiver.kernel.org>; Wed, 10 Apr 2019 20:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E25B920830
	for <rcu@archiver.kernel.org>; Wed, 10 Apr 2019 20:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="C32ORdEl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfDJU3F (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 10 Apr 2019 16:29:05 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44863 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfDJU3F (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 10 Apr 2019 16:29:05 -0400
Received: by mail-pf1-f194.google.com with SMTP id y13so2137328pfm.11
        for <rcu@vger.kernel.org>; Wed, 10 Apr 2019 13:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OSARtBdAUa5vELrhxlT+Gr86I40rv2iuzJgYwzrv0TQ=;
        b=C32ORdEloCt4lQSkRDGrOYBBHPl4R+LSvDLGVdQpi5CywnlXG0Ak0/iK+x/RMEBoVu
         6M/ZQYOrb5tU8IkcDRzbGnVvIbFkm5dHkHOuLtkqmQmSjOU7yfsg216JrHSsRqhzj7JW
         0bXGTWlFTaWdLvSG0hkx6GS7wak1257GNTIyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OSARtBdAUa5vELrhxlT+Gr86I40rv2iuzJgYwzrv0TQ=;
        b=CyX0B+YBeA9V7Or5rp1o0qyHPPdTSHm0t5CIjPJYtgdxO9JCxs0ANS2PzfyeACAqBt
         4UxTPh7Mp9ZpslqkPzg0P4Do9jxR/y63qPJPqr8djvHxd6OaE8GhBpjJt0IZK6H+0PwX
         lFg38yH8LbGZikR7ZjyygCkLTJq8/l04Geu7+i44cXDcI1FVcedNQ0iizGz1nEHeyN+l
         C5HcScw0rprieKzVAoWO6rra43TgEEjmsFoRHasBt0fH9QoZxmvolIciJTvgHRDMfN48
         1v/vqJAV7FfrnU1KpG+y2ZpjJDG41Fa5XoIgAh4lYeEtL8pTQa0gqm/c4F4+0M210pfi
         t7LQ==
X-Gm-Message-State: APjAAAVsPPG2OGUFll9ayd6MvUpfmv3aptJZ76CCa9UX9nnuvHqXXYfE
        hRMy1lS7lSmCxQeTpNSjWS5Bwg==
X-Google-Smtp-Source: APXvYqwQTzQTmSksKSvBLALBSWL4y0FqYe0C+oUvjkGdTf34LeFbYkGy+lf+z5tB/4RdkK3ZaV7b1A==
X-Received: by 2002:a63:88c3:: with SMTP id l186mr43648897pgd.148.1554928144411;
        Wed, 10 Apr 2019 13:29:04 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id u63sm23197025pgd.16.2019.04.10.13.29.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Apr 2019 13:29:03 -0700 (PDT)
Date:   Wed, 10 Apr 2019 16:29:02 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com,
        keescook@chromium.org, mathieu.desnoyers@efficios.com,
        Jessica Yu <jeyu@kernel.org>,
        kernel-hardening@lists.openwall.com, kernel-team@android.com,
        rcu@vger.kernel.org
Subject: Re: [PATCH v3 3/3] module: Make __tracepoints_ptrs as read-only
Message-ID: <20190410202902.GA167446@google.com>
References: <20190410195708.162185-1-joel@joelfernandes.org>
 <20190410195708.162185-3-joel@joelfernandes.org>
 <20190410161112.540017d9@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410161112.540017d9@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Apr 10, 2019 at 04:11:12PM -0400, Steven Rostedt wrote:
> On Wed, 10 Apr 2019 15:57:08 -0400
> "Joel Fernandes (Google)" <joel@joelfernandes.org> wrote:
> 
> > This series hardens the tracepoints in modules by making the array of
> > pointers referring to the tracepoints as read-only. This array is needed
> > during module unloading to verify that the tracepoint is quiescent.
> > There is no reason for the array to be to be writable after init, and
> > can cause security or other hidden bugs. Mark these as ro_after_init.
> > 
> > Suggested-by: paulmck@linux.vnet.ibm.com
> > Suggested-by: keescook@chromium.org
> > Suggested-by: mathieu.desnoyers@efficios.com
> > Cc: rostedt@goodmis.org
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  kernel/module.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/kernel/module.c b/kernel/module.c
> > index 8b9631e789f0..be980aaa8804 100644
> > --- a/kernel/module.c
> > +++ b/kernel/module.c
> > @@ -3320,6 +3320,12 @@ static const char * const ro_after_init_sections[] = {
> >  	 * by the SRCU notifiers
> >  	 */
> >  	"___srcu_struct_ptrs",
> > +
> > +	/*
> > +	 * Array of tracepoint pointers used for checking if tracepoints are
> > +	 * quiescent during unloading.
> > +	 */
> > +	"__tracepoints_ptrs",
> 
> Do we ever modify the __tracepoint_ptrs section? I know the jump_label
> sections are sorted on load, which means they need to be writable
> during init, but if __tracepoint_ptrs is not sorted or touched during
> load, why not just put them in the rodata section to begin with?
> 
> -- Steve

The srcu structure pointer array is modified at module load time because the
array is fixed up by the module loader at load-time with the final locations
of the tracepoints right?  Basically relocation fixups. At compile time, I
believe it is not know what the values in the ptr array are. I believe same
is true for the tracepoint ptrs array.

Also it needs to be in a separate __tracepoint_ptrs so that this code works:


#ifdef CONFIG_TRACEPOINTS
	mod->tracepoints_ptrs = section_objs(info, "__tracepoints_ptrs",
					     sizeof(*mod->tracepoints_ptrs),
					     &mod->num_tracepoints);
#endif

Did I  miss some point? Thanks,

 - Joel

