Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9C7C43334
	for <rcu@archiver.kernel.org>; Fri, 15 Jul 2022 15:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235108AbiGOPST (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 15 Jul 2022 11:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235051AbiGOPSR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 15 Jul 2022 11:18:17 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF747FE6A
        for <rcu@vger.kernel.org>; Fri, 15 Jul 2022 08:18:06 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id m10so3903205qvu.4
        for <rcu@vger.kernel.org>; Fri, 15 Jul 2022 08:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WmLCp6atRZja/OWch1bvuQYw9xsfSFdJHYtbhxjSi7E=;
        b=IkCA0FtJSi08WUdeyMRE5ImSqP32SX6vqUptTpg8TzZco2PB6LTn9Vg8jkB/lIKint
         urp2cTH0Sx8++q/HC6LnOL0LkAuZRS4wc8w3d0nSUArqid0cv3ucVRRsw1CXutD8v4dP
         N6YG1t13tclcSMq4HxBNdVlpE7mDmVrKfvX6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WmLCp6atRZja/OWch1bvuQYw9xsfSFdJHYtbhxjSi7E=;
        b=pY//PAOEKhKPc5CV62UunW786gRvaYefAP8cAcKWugSlkmceEHpP0rSASPWwrdgWO4
         Lgas4nLtVDEam4PCl02FDAwPB9yW+0hcWUauiWdz2M5XCdCuEjtXyc+BaYOaLUOeGB7R
         mdWvFFKoIE9WDTNL9EHhg7B6cOR2C+Q9ZeOZ3OXn7M9lHRrN4ibS4bIDRtrsAqRZhBb+
         aTbc/t4RR/79nPqZIXWmZw15F2i2Z8y/dvER79xfXzelfaNLJYRpo9Juqs8AiJfs5Ekg
         Bwp0WSTR4e2/vOPvJAlK6mbHRCCIqQyWtMyrtdXM05AaefS1+Q+WI9+X93QA1ZWtiYa/
         8tbg==
X-Gm-Message-State: AJIora+L4aYekoAyvYNJQIGOJ2RxGXZjXy4duRx/rEAv6zYfgTK1Hyka
        MMj8WIkxpfUjPCehkllO33c+XQ==
X-Google-Smtp-Source: AGRyM1vYteCq10ZTr/+5rSXoeXspeWAjTtnWQJadan9alEjKQ2FbWsCUI8u+nYt0lg8wrPXEpokvug==
X-Received: by 2002:a05:6214:2308:b0:432:e69f:5d71 with SMTP id gc8-20020a056214230800b00432e69f5d71mr12484540qvb.19.1657898285513;
        Fri, 15 Jul 2022 08:18:05 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id n64-20020a37bd43000000b006b58facde91sm3992444qkf.106.2022.07.15.08.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 08:18:05 -0700 (PDT)
Date:   Fri, 15 Jul 2022 15:18:04 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v3 0/5] Implement call_rcu_lazy() and miscellaneous fixes
Message-ID: <YtGFLFbzuZncfDeN@google.com>
References: <20220713213237.1596225-1-joel@joelfernandes.org>
 <20220714205154.GU1790663@paulmck-ThinkPad-P17-Gen-1>
 <20220714222131.GA3321557@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714222131.GA3321557@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jul 14, 2022 at 03:21:31PM -0700, Paul E. McKenney wrote:
> On Thu, Jul 14, 2022 at 01:51:54PM -0700, Paul E. McKenney wrote:
> > On Wed, Jul 13, 2022 at 09:32:32PM +0000, Joel Fernandes (Google) wrote:
> > > Hello!
> > > 
> > > Please find the next improved version of call_rcu_lazy() attached.  The main
> > > difference between the previous versions is that:
> > > - In v2 rcu_barrier is fixed to not hang (I found this to be due to a missing
> > >   GP thread wakeup), now I am limiting this wake up only to rcu_barrier() as
> > >   requested by Paul.
> > > - Fixed checkpatch and build robot issues.
> > > - Some more changes to 'lazy' parameter passing and consolidation of segcblist
> > >   functions.
> > > - more testing via rcutorture and rcuscale.
> > 
> > Thank you!  What I am going to do is to pull these into an experimental
> > not-for-mainline branch and run the usual set of rcutorture tests.
> > I will then take a look at the patches.
> 
> And there were a few conflicts with the nocb patch series in -rcu.
> The allegedly conflict-resolved series is here: joel.2022.07.14a
> Please let me know if I messed something up.

Thanks, it looks Ok. There is one robot fix for hexagon's arch where I think
TREE_RCU is disabled, could you apply the diff below to patch 1/5 ?

Or, I can also just keep it in my version of 1/5 to go out with the next rev.

---8<-----------------------

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index c358387fd223..aa3243e49506 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -464,6 +464,14 @@ enum rcutorture_type {
 	INVALID_RCU_FLAVOR
 };
 
+#if defined(CONFIG_RCU_LAZY)
+unsigned long rcu_lazy_get_jiffies_till_flush(void);
+void rcu_lazy_set_jiffies_till_flush(unsigned long j);
+#else
+static inline unsigned long rcu_lazy_get_jiffies_till_flush(void) { return 0; }
+static inline void rcu_lazy_set_jiffies_till_flush(unsigned long j) { }
+#endif
+
 #if defined(CONFIG_TREE_RCU)
 void rcutorture_get_gp_data(enum rcutorture_type test_type, int *flags,
 			    unsigned long *gp_seq);
@@ -475,14 +483,6 @@ void do_trace_rcu_torture_read(const char *rcutorturename,
 void rcu_gp_set_torture_wait(int duration);
 void rcu_force_call_rcu_to_lazy(bool force);
 
-#if defined(CONFIG_RCU_LAZY)
-unsigned long rcu_lazy_get_jiffies_till_flush(void);
-void rcu_lazy_set_jiffies_till_flush(unsigned long j);
-#else
-static inline unsigned long rcu_lazy_get_jiffies_till_flush(void) { return 0; }
-static inline void rcu_lazy_set_jiffies_till_flush(unsigned long j) { }
-#endif
-
 #else
 static inline void rcutorture_get_gp_data(enum rcutorture_type test_type,
 					  int *flags, unsigned long *gp_seq)
