Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CFBC433C1
	for <rcu@archiver.kernel.org>; Tue, 23 Mar 2021 14:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5F50619B2
	for <rcu@archiver.kernel.org>; Tue, 23 Mar 2021 14:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbhCWOCe (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 23 Mar 2021 10:02:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:56996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232177AbhCWOCK (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 23 Mar 2021 10:02:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4EB38619B2;
        Tue, 23 Mar 2021 14:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616508129;
        bh=V9SR3dGkHatwy10WvCFJJlFM8joEHNaQgtRFNoPR3Ck=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U2GoGF/1bpVkAexjpZjMq728p3wpvh+2OW5T9tA8jL8+Niisqm8pFpZBjQxNmRCPm
         5fw+ctJSasGS0zPqcZGVNrj3GNMgGHqSrJyYd+0WtKsJ4nn2fyE/tD85wxK+53QefC
         GfoT4Bstg6HaIMRvhfFLnJOqTUGWyid58e6N7tlyCr8v5IN0tqV5KnOnRpao7nZwZ+
         S9HC8tkuIKJRmUdGdEcRXBrWJP+timG191D/x619ggQZPooqFrqi9AgjTD90rum29I
         Remu8ofigcjL/5fOfsSq1FB5LlkmMwgxKiqzQnY+h9V1qnEJbUeM6lmn9ioIS0EJ57
         zjeYflVDOswHQ==
Date:   Tue, 23 Mar 2021 15:02:07 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 2/3] rcu: Provide polling interfaces for
 Tiny RCU grace periods
Message-ID: <20210323140207.GA890343@lothringen>
References: <20210304002605.GA23785@paulmck-ThinkPad-P72>
 <20210304002632.23870-2-paulmck@kernel.org>
 <20210321222855.GA863290@lothringen>
 <20210322154744.GM2696@paulmck-ThinkPad-P72>
 <20210322190035.GA874833@lothringen>
 <20210322194522.GO2696@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322194522.GO2696@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Mar 22, 2021 at 12:45:22PM -0700, Paul E. McKenney wrote:
> On Mon, Mar 22, 2021 at 08:00:35PM +0100, Frederic Weisbecker wrote:
> > But poll_state_synchronize_rcu() checks that the gp_num has changed,
> > which is not needed for cond_synchronize_rcu() since this it is
> > only allowed to be called from a QS.
> 
> Good catch, and thank you!  Back to a single might_sleep() it is!

And then: Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Thanks!
