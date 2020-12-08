Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40671C433FE
	for <rcu@archiver.kernel.org>; Tue,  8 Dec 2020 02:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7F6423433
	for <rcu@archiver.kernel.org>; Tue,  8 Dec 2020 02:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgLHCna (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 7 Dec 2020 21:43:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727281AbgLHCna (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 7 Dec 2020 21:43:30 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F398C061749;
        Mon,  7 Dec 2020 18:42:50 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id z3so11051497qtw.9;
        Mon, 07 Dec 2020 18:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cZnPt0NATLBlJ+EJ8exaDscQ3NnykmkR46SyDarrbYI=;
        b=hfPTw4x4tdQGwSZUmsdHH7XeyFtqTs6UG8vkIHX3hBd4E7Z9SMwvqDoDDQCeIzdgS2
         hKb3VlzrbIQFfFfxLSykb4IMK2KRZpw7C6JO1mj1qaWGkGAA+SYkYIKjmE1AzsFbwVOk
         cRJvjGF0UNgKf89Rx+mhzVcUcm9o84ATODYfzLT9sl0D/2FKoVAkrJXYjqL1xd7XNxja
         uAZGa8MvMgouHu5J/pV1Gc9ZomaaJSf7vaFO4dBvClfujKPqI2fwrzNsWqzkPp8DT3wH
         sKyi/gK8V0UUkciLcd7ZEB8BmALp6nnc36kXYs+vbz8zHvrnfzaWe4Y36uOr3HO5+6YH
         9mMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cZnPt0NATLBlJ+EJ8exaDscQ3NnykmkR46SyDarrbYI=;
        b=RwZIfarEGuYDeiLGTYnraMH4M6xBR5PdO6KCcInQ7AZ9dSW/yKjVwBPJAZeD41Y9ee
         nzQ8BcVjKmquvNR4yb5FNAwF2FMRWfrR9tPYm/Iv2vtrUgg2Mg7twmgiFBaNBACD7Or/
         oZjy/FPK6wG2m8RKXcTm85lqsGMlfs39KgL7dbqFKotAVV4e6Qocql9KaqQOG88D7va2
         nylxDsC0rWsfUqp4QmmEhaFEZga2H17Q84LHjuInSh2b6IaF0hLrpo3adn5xdX0DFQT2
         NabRZvA36nBXyEcZO5dUVQ12tF+cpe9Y5lGuM9OMYYBhPm8Vr42tEmxia+ccJyZAZ/HJ
         N6cQ==
X-Gm-Message-State: AOAM532acEdz97oV01jx981fMxIKXFj+HgMyGE7KypX6ozt6M7ypUikF
        3UNa6DSyrh5YcyGsvA7pkLQ=
X-Google-Smtp-Source: ABdhPJwiTptH6sp15n8iIXwKV0kIWZPim4w5OND6BMi5Cin0R5S0bjpAT5FeQew2XfkHR/w4mRHxYg==
X-Received: by 2002:ac8:36a3:: with SMTP id a32mr28573387qtc.90.1607395369367;
        Mon, 07 Dec 2020 18:42:49 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id o13sm12590778qkm.78.2020.12.07.18.42.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2020 18:42:48 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 1EDD127C0054;
        Mon,  7 Dec 2020 21:42:47 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 07 Dec 2020 21:42:47 -0500
X-ME-Sender: <xms:JejOXxkgvrmfzKyh0bjlqT_-1WKSGmkhlpYwhfHb7nFNFB1z4iXAEA>
    <xme:JejOX808zHPrTuDWdaru4Xjevj07Jk28Wuixxqj4XGFh-cEweDq-FiM10nvbXZ0MN
    9mMcWPGOCeaAF0MgA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudejhedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepveeijedthfeijeefudehhedvveegudegteehgffgtddvuedtveegtedvvdef
    gedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudeijedrvddvtddrvd
    druddvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtd
    eigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehf
    ihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:JejOX3pp8pY41j7NDhStTBgJJrZExgZQV3kp79TU23i0fwS2OLzLIg>
    <xmx:JejOXxnxVV0ReqmuTecybo6sl8JTBcQLTq2smf7NflCcNHIodzvV_g>
    <xmx:JejOX_3hgyECxnxXXJyNiSnm5VmUn-pi9XiXPPyxZQgPCkhgP6RUkQ>
    <xmx:J-jOXxyKHRss5ucJcwTNoygu97Rrt8A8iP4vK8dJ0oqzivleiWmAp4j4emc>
Received: from localhost (unknown [167.220.2.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id AD45224005B;
        Mon,  7 Dec 2020 21:42:45 -0500 (EST)
Date:   Tue, 8 Dec 2020 10:41:31 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 00/19] rcu/nocb: De-offload and re-offload support v4
Message-ID: <20201208024131.GI3025@boqun-archlinux>
References: <20201113121334.166723-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113121334.166723-1-frederic@kernel.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Frederic,

On Fri, Nov 13, 2020 at 01:13:15PM +0100, Frederic Weisbecker wrote:
> This keeps growing up. Rest assured, most of it is debug code and sanity
> checks.
> 
> Boqun Feng found that holding rnp lock while updating the offloaded
> state of an rdp isn't needed, and he was right despite my initial
> reaction. The sites that read the offloaded state while holding the rnp
> lock are actually protected because they read it locally in a non
> preemptible context.
> 
> So I removed the rnp lock in "rcu/nocb: De-offloading CB". And just to
> make sure I'm not missing something, I added sanity checks that ensure
> we always read the offloaded state in a safe way (3 last patches).
> 
> Still passes TREE01 (but I had to fight!)
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
> 	rcu/nocb-toggle-v4
> 
> HEAD: 579e15efa48fb6fc4ecf14961804051f385807fe
> 

This whole series look good to me, plus I've run a test, so far
everything seems working ;-) Here is my setup for the test:

I'm using a ARM64 guest (running on Hyper-V) to do the test, and the
guest has 8 VCPUs. The code I'm using is v5.10-rc6 + Hyper-V ARM64 guest
support [1] + your patchset (I actually did a merge from your
rcu/nocb-toggle-v5 branch, because IIUC some modification for rcutorture
is still in Paul's tree). I compiled with my normal configuration for
ARM64 Hyper-V guest plus TREE01, boot the kernel with:

	ignore_loglevel rcutree.gp_preinit_delay=3 rcutree.gp_init_delay=3 rcutree.gp_cleanup_delay=3 rcu_nocbs=0-1,3-7	

and run rcutorture via:

	modprobe rcutorture nocbs_nthreads=8 nocbs_toggle=1000 fwd_progress=0

I ran the rcutorture twice, one last for a week or so and one for a day
or two and I didn't observe any problem so far. The latest test summary
is:

	[...] rcu-torture: rtc: 00000000f794686f ver: 2226396 tfle: 0 rta: 2226397 rtaf: 0 rtf: 2226385 rtmbe: 0 rtmbkf: 0/1390141 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 181415346 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=1000) barrier: 0/0:0 read-exits: 108102 nocb-toggles: 306964:306974 

Is there anything I'm missing for a useful test? Do you have other setup
(kernel cmdline or rcutorture parameters) that you want me to try?

Regards,
Boqun

> Thanks,
> 	Frederic
> ---
> 
> Frederic Weisbecker (19):
>       rcu/nocb: Turn enabled/offload states into a common flag
>       rcu/nocb: Provide basic callback offloading state machine bits
>       rcu/nocb: Always init segcblist on CPU up
>       rcu/nocb: De-offloading CB kthread
>       rcu/nocb: Don't deoffload an offline CPU with pending work
>       rcu/nocb: De-offloading GP kthread
>       rcu/nocb: Re-offload support
>       rcu/nocb: Shutdown nocb timer on de-offloading
>       rcu: Flush bypass before setting SEGCBLIST_SOFTIRQ_ONLY
>       rcu/nocb: Set SEGCBLIST_SOFTIRQ_ONLY at the very last stage of de-offloading
>       rcu/nocb: Only cond_resched() from actual offloaded batch processing
>       rcu/nocb: Process batch locally as long as offloading isn't complete
>       rcu/nocb: Locally accelerate callbacks as long as offloading isn't complete
>       tools/rcutorture: Support nocb toggle in TREE01
>       rcutorture: Remove weak nocb declarations
>       rcutorture: Export nocb (de)offloading functions
>       cpu/hotplug: Add lockdep_is_cpus_held()
>       timer: Add timer_curr_running()
>       rcu/nocb: Detect unsafe checks for offloaded rdp
> 
> 
>  include/linux/cpu.h                                |   1 +
>  include/linux/rcu_segcblist.h                      | 119 +++++-
>  include/linux/rcupdate.h                           |   4 +
>  include/linux/timer.h                              |   2 +
>  kernel/cpu.c                                       |   7 +
>  kernel/rcu/rcu_segcblist.c                         |  13 +-
>  kernel/rcu/rcu_segcblist.h                         |  45 ++-
>  kernel/rcu/rcutorture.c                            |   3 -
>  kernel/rcu/tree.c                                  |  49 ++-
>  kernel/rcu/tree.h                                  |   2 +
>  kernel/rcu/tree_plugin.h                           | 416 +++++++++++++++++++--
>  kernel/time/timer.c                                |  13 +
>  .../selftests/rcutorture/configs/rcu/TREE01.boot   |   4 +-
>  13 files changed, 614 insertions(+), 64 deletions(-)
