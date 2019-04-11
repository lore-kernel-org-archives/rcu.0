Return-Path: <SRS0=j/BQ=SN=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADD2C10F14
	for <rcu@archiver.kernel.org>; Thu, 11 Apr 2019 20:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAB1320850
	for <rcu@archiver.kernel.org>; Thu, 11 Apr 2019 20:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="VIOhwHDU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbfDKUGO (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 11 Apr 2019 16:06:14 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37954 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfDKUGN (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 11 Apr 2019 16:06:13 -0400
Received: by mail-pf1-f195.google.com with SMTP id 10so3972066pfo.5
        for <rcu@vger.kernel.org>; Thu, 11 Apr 2019 13:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=33mEP7tbzfOYcDBGIZUOmFHkLkGTwi8h/F9OkEGYBn4=;
        b=VIOhwHDUmhRtKAyDseH3thEZN5Al79WBRcOs868zuNxTZFDJ2wNg9BtfQkyEsNZkPZ
         +C/2wpv48l1XDSYpn5MmvvNfQbtFZbIlpdWyuNoBMU2+FKK1szfTHqGsR7eMXG0r69L6
         yfyhpFHoNVKihw67J4PNiST5D4LoZiDOPyfxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=33mEP7tbzfOYcDBGIZUOmFHkLkGTwi8h/F9OkEGYBn4=;
        b=kOs4AIGK1SW2zBTzPywcu/MprmpLEVf7NUOyF73ap8sNt39Halhpxyffst1+ahCVtq
         Q2i9t2LAd5UDu/GHWtTu0eAhELQYGx+Cy6zHumoE+VFWxBWNl6YO9w1fKw2nqhCUtV9p
         tRLowlTK23UP5bTy1F4/HZwnCMzg8oyqeNe+4hDkipOkmiFrFQ4PVwwe8H/FVHWengw7
         E/0A8G8DAxVGIo5HO8w0oQUyZNg8l1oQLdb3Wbwu85/q1PGTyma7Uy8ebpqF71USTOtV
         6DXImZGY1tS10Cbq0CEg46CZ4RnAQTve4PhFAskpUE8jCO4U33QUsHwugH0ry2WFPc+m
         X4pA==
X-Gm-Message-State: APjAAAWWeP+dO0PE4mFZWLOTBhzaYvqHzovhcJS4R55cDSZMUJ5M3tGB
        HxB14UGMn2r/1cHDvfA4weZE8MOD+3o=
X-Google-Smtp-Source: APXvYqwB5DtGkh435cnR8fMLFN1Yc803RjIiMHi9ATh0RzmfFWCO2sEt2j1pHk6KYYj/drUph8WtYw==
X-Received: by 2002:a63:2a8f:: with SMTP id q137mr47908875pgq.31.1555013172973;
        Thu, 11 Apr 2019 13:06:12 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id l88sm66103469pfb.104.2019.04.11.13.06.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Apr 2019 13:06:11 -0700 (PDT)
Date:   Thu, 11 Apr 2019 16:06:10 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com,
        keescook@chromium.org, mathieu.desnoyers@efficios.com,
        Jessica Yu <jeyu@kernel.org>,
        kernel-hardening@lists.openwall.com, kernel-team@android.com,
        rcu@vger.kernel.org
Subject: Re: [PATCH v3 3/3] module: Make __tracepoints_ptrs as read-only
Message-ID: <20190411200610.GB75190@google.com>
References: <20190410195708.162185-1-joel@joelfernandes.org>
 <20190410195708.162185-3-joel@joelfernandes.org>
 <20190410161112.540017d9@gandalf.local.home>
 <20190410202902.GA167446@google.com>
 <20190410204401.62f928ca@gandalf.local.home>
 <20190411082106.GB167446@google.com>
 <20190411091955.67cdd9fd@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411091955.67cdd9fd@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Apr 11, 2019 at 09:19:55AM -0400, Steven Rostedt wrote:
> On Thu, 11 Apr 2019 04:21:06 -0400
> Joel Fernandes <joel@joelfernandes.org> wrote:
> 
> > Patch 2/3 and 3/3 would not be nececessary if this works out. 1/3 may be a
> > nice clean up but is not something urgent and we could do that in the future
> > if needed.
> 
> Well, jump_labels is "special" because it requires sorting the RO data
> and is done via module notify. The only other user that had to modify
> RO data on module load is ftrace. It had to do the nop conversions in
> the text area. It use to do it via module notify, but because of the
> hardening of the kernel, doing it there was no longer possible because
> everything was RO then. The solution was to call into ftrace directly
> from the module code instead of a notifier. This was done before
> sections were made RO.
> 
> One option is to do the same with jump_labels and just have a call to
> the sorting before the notifiers and before the section gets turned
> into RO. Or I would say just leave it as is. As I stated, jump_labels
> are "special" and adding a loop of one section where I don't envision
> any other sections needing to do the same thing for a long time to
> come. I would save that patch for if there is another section that
> comes along that needs to be modify at module notify.

Sounds good, thanks for the detailed history of this. It sounds like you are
Ok with making of the srcu pointer array as const, which I will test shortly
and send it out for your review. And we can drop this patch series for now.

thanks,

 - Joel
