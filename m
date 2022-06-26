Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233D9C433EF
	for <rcu@archiver.kernel.org>; Sun, 26 Jun 2022 14:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiFZOhZ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 26 Jun 2022 10:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiFZOhY (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 26 Jun 2022 10:37:24 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88388DFCA
        for <rcu@vger.kernel.org>; Sun, 26 Jun 2022 07:37:23 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id q4so11489049qvq.8
        for <rcu@vger.kernel.org>; Sun, 26 Jun 2022 07:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZQN6rdXZBeRbBi6GH04arvPTXSrKXpzLHtzZj9DXNVE=;
        b=lA2BlcAaOVpZDxOT8XkzpGCat+hcNgXLVjJuuUUtLzNtVUT6SSpQTCagJtwzGwDMPS
         q9pqOUuUdwiPB8b0YL2nNy5IvmtfOeh1IXWGWr424UmaFGMd2KGQS3DG/LcNgvZk10ke
         S+AUUxeVmU2UsJVxuJKiEgCSr3c9O/r95YoZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZQN6rdXZBeRbBi6GH04arvPTXSrKXpzLHtzZj9DXNVE=;
        b=q8B0GTSSMzBVD7UiMUyZd67EdOiEh6R6vrd934ZkkK4ZkK4PDuhuFe6GwhxeoGEXae
         QMnDBBT4zxhFQWHTLCoRRrwCBc+axtyKzRZKRJ27IgHeZ2cmaHnndftJBn/SE2GyZVc8
         H5prRXOzyDF5VSDpDyd28ci1jYCtJOMQ/34pfk3t1MauEvAVNMv+Uq5JU3+hebmG1mlX
         TPPWrMPbFckXmLCa+jLc847o7R8tTGK3ilCVppFPyYl92of9fYUYlhRsQTXx91PcBcWi
         Os4+nYn/sGdYpvYlclg+d1Zza+g4x8BEkL1Ydh0w8lC9qM/WHq/MaKRjrZ3YAdOrISfX
         M4RQ==
X-Gm-Message-State: AJIora99dpNY3EYGJtwNtmT/i9MYTnFoN9P7cVIwILIhi1svhi9qDpFc
        OEuT4KTWd98Mrzb7TK1RhW6zvA==
X-Google-Smtp-Source: AGRyM1s+8y5vj/HBVvv+O0uvVJ3pftXmeAs5pWvNgkAERy88K99A+wR4w8mYn/L0mL3qTuVinkxXgA==
X-Received: by 2002:ac8:5f0f:0:b0:305:1fc0:482 with SMTP id x15-20020ac85f0f000000b003051fc00482mr6115094qta.121.1656254242692;
        Sun, 26 Jun 2022 07:37:22 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id p13-20020a05622a13cd00b0030a9dfb2898sm5245765qtk.85.2022.06.26.07.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 07:37:22 -0700 (PDT)
Date:   Sun, 26 Jun 2022 14:37:22 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org,
        vineeth@bitbyteword.org
Subject: Re: [PATCH v2 5/8] rcu/nocb: Wake up gp thread when flushing
Message-ID: <YrhvIqnl/n3HaHUf@google.com>
References: <20220622225102.2112026-1-joel@joelfernandes.org>
 <20220622225102.2112026-7-joel@joelfernandes.org>
 <20220626040622.GM1790663@paulmck-ThinkPad-P17-Gen-1>
 <Yrhi/Jwm0eLmDIGb@google.com>
 <20220626135240.GP1790663@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220626135240.GP1790663@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Jun 26, 2022 at 06:52:40AM -0700, Paul E. McKenney wrote:
> On Sun, Jun 26, 2022 at 01:45:32PM +0000, Joel Fernandes wrote:
> > On Sat, Jun 25, 2022 at 09:06:22PM -0700, Paul E. McKenney wrote:
> > > On Wed, Jun 22, 2022 at 10:50:59PM +0000, Joel Fernandes (Google) wrote:
> > > > We notice that rcu_barrier() can take a really long time. It appears
> > > > that this can happen when all CBs are lazy and the timer does not fire
> > > > yet. So after flushing, nothing wakes up GP thread. This patch forces
> > > > GP thread to wake when bypass flushing happens, this fixes the
> > > > rcu_barrier() delays with lazy CBs.
> > > 
> > > I am wondering if there is a bug in non-rcu_barrier() lazy callback
> > > processing hiding here as well?
> > 
> > I don't think so because in both nocb_try_bypass and nocb_gp_wait, we are not
> > going to an indefinite sleep after the flush. However, with rcu_barrier() ,
> > there is nothing to keep the RCU GP thread awake. That's my theory at least.
> > In practice, I have not been able to reproduce this issue with
> > non-rcu_barrier().
> > 
> > With rcu_barrier() I happen to hit it thanks to the rcuscale changes I did.
> > That's an interesting story! As I apply call_rcu_lazy() to the file table
> > code, turns out that on boot, the initram unpacking code continously triggers
> > call_rcu_lazy(). This happens apparently in a different thread than the one
> > that rcuscale is running in. In rcuscale, I did rcu_barrier() at init time
> > and this stalled for a long time to my surprise, and this patch fixed it.
> 
> Cool!
> 
> Then should this wake_nocb_gp() instead go into the rcu_barrier()
> code path?  As shown below, wouldn't we be doing some spurious wakeups?

You are right. In my testing, I don't see any issue with the extra wake up
which is going to happen anyway and my thought was why not do it so that a
future bypass flush from some other path forgets to call wake up.

I'll refine it to be rcu-barrier-only then.

thanks!

 - Joel

