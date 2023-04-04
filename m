Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97404C6FD1D
	for <rcu@archiver.kernel.org>; Tue,  4 Apr 2023 14:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235256AbjDDOAG (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 4 Apr 2023 10:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235465AbjDDN71 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 4 Apr 2023 09:59:27 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FC810F6
        for <rcu@vger.kernel.org>; Tue,  4 Apr 2023 06:59:00 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id s12so27960268qtx.11
        for <rcu@vger.kernel.org>; Tue, 04 Apr 2023 06:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1680616662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JiIK93wZ7uSv4J8mxJGBVVQMHkFGXvgas7+YLZxFgk8=;
        b=W2ZZXSSvoqKK85OBtftLMhokRrUR88SqHxWQbB1PO4amVFNmKoFUqLMKg6m5dUelSP
         4VYmFRjUa27+snW83x7lC/lmZJbWmwjhiff0Cva1vDLnHosjhTpPBNZfnnGK/tYMNnWe
         DjFJ/qR6wjnIIMGZ8JAQ9C/celmu9KR2NnT+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680616662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JiIK93wZ7uSv4J8mxJGBVVQMHkFGXvgas7+YLZxFgk8=;
        b=aZ8AgOMr1x0OrUMF9s8yCMKw2wmHqxbFhLVkBaruEi6FFfTSjsp2V7b5eZdgT78udP
         qJTUFi3y2B5qeonOiruJCDgey51n4THh8hFjsJlrsl/9oiSZ1aEB+xqx/yFzLd16dLxt
         ye72E2Mt3rNeciikkG/n48sFhssCT8bl/uIufLtQZ+zCtm1Rw2cAXI9I+iByLVX3cFO5
         lTgtqGEMAwHhkRa9daYOE1TzN7PRfFoWEMep9O91Yk8Gm8Oic19pn2b/SD8Hb4VGVY/O
         TL0Z0EdWFSXVqi7ThyH5PGGixqFLEm/5NaBAcoLQNAV4gPg3GV6zQtomm0O2+gV0uztL
         gPew==
X-Gm-Message-State: AAQBX9c8DMu7aGeNKEaKop7drIoLvumUh2ClAGzAyrT7NOzQgnzfwf77
        7VlkDeYuUUbdpB7p6FLSNeb8+A==
X-Google-Smtp-Source: AKy350bSHyobHLgm0WOYJUJYV15CA09NYOQT1uk0PNkAXAzMqVpLF440ix/aziMAwUdGPQpvcNZWVg==
X-Received: by 2002:ac8:59cd:0:b0:3e4:e2fa:66b0 with SMTP id f13-20020ac859cd000000b003e4e2fa66b0mr3338791qtf.29.1680616661970;
        Tue, 04 Apr 2023 06:57:41 -0700 (PDT)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id p11-20020a05620a22ab00b00706b09b16fasm3606294qkh.11.2023.04.04.06.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 06:57:41 -0700 (PDT)
Date:   Tue, 4 Apr 2023 13:57:41 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org, hch@lst.de
Subject: Re: [PATCH rcu 0/20] Further shrink srcu_struct to promote cache
 locality
Message-ID: <20230404135741.GB471948@google.com>
References: <f1b6cd5f-f0b7-4748-abd5-0dcfef0ce126@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1b6cd5f-f0b7-4748-abd5-0dcfef0ce126@paulmck-laptop>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Mar 30, 2023 at 03:47:02PM -0700, Paul E. McKenney wrote:
> Hello!
> 
> This post-RFC series shrinks the srcu_struct structure to the bare minimum
> required to support SRCU readers, relegating the remaining fields to a new
> srcu_usage structure.  Statically allocated srcu_struct structures created
> by DEFINE_SRCU() and DEFINE_STATIC_SRCU() have statically allocated
> srcu_usage structures, but those required for dynamically allocated
> srcu_struct structures that are initialized using init_srcu_struct()
> are dynamically allocated.
> 
> The results is a reduction in the size of an srcu_struct structure from
> a couple hundred bytes to just 24 bytes on x86_64 systems.  This can be
> helpful when SRCU readers are used in a fastpath for which the srcu_struct
> structure must be embedded in another structure, and especially where
> that fastpath also needs to access fields both before and after the
> srcu_struct structure.
> 
> This series takes baby steps, in part because breaking SRCU means that
> you get absolutely no console output.  Yes, I did learn this the hard way.
> Why do you ask?  ;-)
> 
> Here are those baby steps:
> 
> 1.	rcu-tasks: Fix warning for unused tasks_rcu_exit_srcu.
> 
> 2.	Add whitespace to __SRCU_STRUCT_INIT() & __DEFINE_SRCU().
> 
> 3.	Use static init for statically allocated in-module srcu_struct.
> 
> 4.	Begin offloading srcu_struct fields to srcu_update.
> 
> 5.	Move ->level from srcu_struct to srcu_usage.
> 
> 6.	Move ->srcu_size_state from srcu_struct to srcu_usage.
> 
> 7.	Move ->srcu_cb_mutex from srcu_struct to srcu_usage.
> 
> 8.	Move ->lock initialization after srcu_usage allocation.
> 
> 9.	Move ->lock from srcu_struct to srcu_usage.
> 
> 10.	Move ->srcu_gp_mutex from srcu_struct to srcu_usage.
> 
> 11.	Move grace-period fields from srcu_struct to srcu_usage.
> 
> 12.	Move heuristics fields from srcu_struct to srcu_usage.
> 
> 13.	Move ->sda_is_static from srcu_struct to srcu_usage.
> 
> 14.	Move srcu_barrier() fields from srcu_struct to srcu_usage.
> 
> 15.	Move work-scheduling fields from srcu_struct to srcu_usage.
> 
> 16.	Check for readers at module-exit time.
> 
> 17.	Fix long lines in srcu_get_delay().
> 
> 18.	Fix long lines in cleanup_srcu_struct().
> 
> 19.	Fix long lines in srcu_gp_end().
> 
> 20.	Fix long lines in srcu_funnel_gp_start().
> 
> Changes since the RFC series:
> https://lore.kernel.org/all/3db82572-f156-4a5d-b711-841aa28bd996@paulmck-laptop/
> 
> 1.	Add checks for readers of in-module statically allocated
> 	srcu_struct structures persisting past module unload.
> 
> 2.	Apply Tested-by tags.
> 
> 3.	Apply feedback from "Zhang, Qiang1" and kernel test robot,
> 	perhaps most notably getting rid of memory leaks and improving
> 	the handling of statically allocated srcu_struct structures
> 	defined within modules.
> 
> 4.	Drop the commit removing extraneous parentheses given the desire
> 	to push this into the v6.4 merge window, the fact that this
> 	commit generates conflicts with other v6.4 RCU commits, and the
> 	low value of this commit.  It therefore remains in the v6.5 pile.
> 
> 						Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
>  b/include/linux/notifier.h |    5 
>  b/include/linux/srcutiny.h |    6 
>  b/include/linux/srcutree.h |   28 +-
>  b/kernel/rcu/rcu.h         |    6 
>  b/kernel/rcu/srcutree.c    |   19 +
>  b/kernel/rcu/tasks.h       |    2 
>  include/linux/srcutree.h   |  123 ++++++-----
>  kernel/rcu/srcutree.c      |  495 +++++++++++++++++++++++----------------------
>  8 files changed, 370 insertions(+), 314 deletions(-)

It looks good on my ARM64 board:
Tested-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Output of run:

tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 2h --configs SRCU-P SRCU-N SRCU-T SRCU-U --trust-make
SRCU-N ------- 204135 GPs (28.3521/s) [srcu: g1765408 f0x0 total-gps=1765408] n_max_cbs: 150000
:CONFIG_HYPERVISOR_GUEST=y: improperly set
:CONFIG_KVM_GUEST=y: improperly set
SRCU-P ------- 105511 GPs (14.6543/s) [srcud: g884128 f0x0 total-gps=884128] n_max_cbs: 150000
:CONFIG_HYPERVISOR_GUEST=y: improperly set
:CONFIG_KVM_GUEST=y: improperly set
SRCU-T ------- 334055 GPs (46.3965/s) [srcu: g2638072 f0x0 total-gps=2638072] n_max_cbs: 50000
:CONFIG_HYPERVISOR_GUEST=y: improperly set
:CONFIG_KVM_GUEST=y: improperly set
:CONFIG_SMP: improperly set
:CONFIG_TINY_SRCU=y: improperly set
SRCU-U ------- 292738 GPs (40.6581/s) [srcud: g2349416 f0x0 total-gps=2349416] n_max_cbs: 50000
:CONFIG_HYPERVISOR_GUEST=y: improperly set
:CONFIG_KVM_GUEST=y: improperly set
:CONFIG_SMP: improperly set
:CONFIG_TINY_SRCU=y: improperly set
1 runs with build errors.

That "build error" is actually perl doing this:

perl: warning: Please check that your locale settings:
perl: warning: Falling back to the standard locale ("C").

I think its harmless and the test did fine. It is just that my chroot is
missing some packages (I have run into this warning before).

The "improperly set" thingies are perhaps Kconfig on ARM64 setting some KVM
options slightly differently. I have seen that before as well on this board.

thanks,

 - Joel

