Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0458DECAAD2
	for <rcu@archiver.kernel.org>; Thu,  1 Sep 2022 22:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbiIAWSB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 1 Sep 2022 18:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234235AbiIAWR7 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 1 Sep 2022 18:17:59 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CA654C81
        for <rcu@vger.kernel.org>; Thu,  1 Sep 2022 15:17:58 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id l5so143124qvs.13
        for <rcu@vger.kernel.org>; Thu, 01 Sep 2022 15:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=afuocE6taLvIUkuxP21NM/dG/RD/5FKKBjM6n34E6m0=;
        b=pRUB0zg4JoOEB0uhNP37+w1nfFaAZcUn3QYeJ0TBaE7kHlOQcv8v3tmJjThMLcgSnt
         uLr4rd5vYRgxWDq6/UefWKw4dVj5+NF069S7spnfM+6DA3YkztwVUrGvxQCugGYDdhCf
         m2uKcv7W0TOiWV/W1ATZfB//V7BUJCV/wrIDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=afuocE6taLvIUkuxP21NM/dG/RD/5FKKBjM6n34E6m0=;
        b=0KXrdfr2WGiBzeL4GO/uwhyb3P7s5yS0VITo1LOiPHTVlcHvOxzwNkgE2lA0BcIuhv
         IX8Exi8j5Xt43rk/Lp062K7KgPetu+UDj5KGzSBsbVooP2uZfhlfMVkRZhb/ZZQnayt9
         8IgZcqBipHQhQL3DpPpkmsuLxESAm4jBAoIvqiFREUqmyGkeXNmow+sRpZAOR5Qjmi+0
         CdkZn9bGdhg16zUgevyZIXvTCwTJ8KVsP1qAahgCVc+ZN+lVje/QIvN+9hLCEyBIyAGD
         FEfvQBxKcyvUcfiMksKvcNWQhakS45WjEnqhTHwoS4/x3jlSzLPEr7ci3mF80Up23CtA
         Wo4g==
X-Gm-Message-State: ACgBeo0w6VxYZWAt5iPBd3GQwatRzT+rQq2ILGba3Se41ptv9vFO2BbI
        +lOL/eLDqJyNDuur+xDSr+/W2Vyg6w9gmg==
X-Google-Smtp-Source: AA6agR62w5nnuV0n32XPHe1SW+3VVJjXoTVS8pBX/NwLnTNGpfB6F5kWxJFpefxQSNBTotIcH/xnxQ==
X-Received: by 2002:a05:6214:e44:b0:496:b443:628b with SMTP id o4-20020a0562140e4400b00496b443628bmr26724638qvc.10.1662070677513;
        Thu, 01 Sep 2022 15:17:57 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id s16-20020ac85290000000b0034305a91aaesm11060794qtn.83.2022.09.01.15.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 15:17:57 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, vineeth@bitbyteword.org,
        boqun.feng@gmail.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v5 00/18] Implement call_rcu_lazy() and miscellaneous fixes
Date:   Thu,  1 Sep 2022 22:17:02 +0000
Message-Id: <20220901221720.1105021-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Here is v5 of call_rcu_lazy() based on the latest RCU -dev branch. Main changes are:
- moved length field into rcu_data (Frederic suggestion)
- added new traces to aid debugging and testing.
	- the new trace patch (along with the rcuscale and rcutorture tests)
	  gives confidence that the patches work well. Also it is tested on
	  real ChromeOS hardware and the boot time is looking good even though
	  lazy callbacks are being queued (i.e. the lazy ones do not effect the
	  synchronous non-lazy ones that effect boot time)
- rewrote some parts of the core patch.
- for rcutop, please apply the diff in the following link to the BCC repo:
  https://lore.kernel.org/r/Yn+79v4q+1c9lXdc@google.com
  Then, cd libbpf-tools/ and run make to build the rcutop static binary.
  (If you need an x86 binary, ping me and I'll email you).
  In the future, I will attempt to make rcutop built within the kernel repo.
  This is already done for another tool (see tools/bpf/runqslower) so is doable.

The 2 mm patches are what Vlastimil pulled into slab-next. I included them in
this series so that the tracing patch builds.

Previous series was posted here:
 https://lore.kernel.org/all/20220713213237.1596225-1-joel@joelfernandes.org/

Linked below [1] is some power data I collected with Turbostat on an x86
ChromeOS ADL machine. The numbers are not based on -next, but rather 5.19
kernel as that's what booted on my ChromeOS machine).

These are output by Turbostat, by running:
turbostat -S -s PkgWatt,CorWatt --interval 5
PkgWatt - summary of package power in Watts 5 second interval.
CoreWatt - summary of core power in Watts 5 second interval.

[1] https://lore.kernel.org/r/b4145008-6840-fc69-a6d6-e38bc218009d@joelfernandes.org

Joel Fernandes (Google) (15):
rcu/tree: Use READ_ONCE() for lockless read of rnp->qsmask
rcu: Fix late wakeup when flush of bypass cblist happens
rcu: Move trace_rcu_callback() before bypassing
rcu: Introduce call_rcu_lazy() API implementation
rcu: Add per-CB tracing for queuing, flush and invocation.
rcuscale: Add laziness and kfree tests
rcutorture: Add test code for call_rcu_lazy()
fs: Move call_rcu() to call_rcu_lazy() in some paths
cred: Move call_rcu() to call_rcu_lazy()
security: Move call_rcu() to call_rcu_lazy()
net/core: Move call_rcu() to call_rcu_lazy()
kernel: Move various core kernel usages to call_rcu_lazy()
lib: Move call_rcu() to call_rcu_lazy()
i915: Move call_rcu() to call_rcu_lazy()
fork: Move thread_stack_free_rcu() to call_rcu_lazy()

Vineeth Pillai (1):
rcu: shrinker for lazy rcu

Vlastimil Babka (2):
mm/slub: perform free consistency checks before call_rcu
mm/sl[au]b: rearrange struct slab fields to allow larger rcu_head

drivers/gpu/drm/i915/gem/i915_gem_object.c    |   2 +-
fs/dcache.c                                   |   4 +-
fs/eventpoll.c                                |   2 +-
fs/file_table.c                               |   2 +-
fs/inode.c                                    |   2 +-
include/linux/rcupdate.h                      |   6 +
include/linux/types.h                         |  44 +++
include/trace/events/rcu.h                    |  69 ++++-
kernel/cred.c                                 |   2 +-
kernel/exit.c                                 |   2 +-
kernel/fork.c                                 |   6 +-
kernel/pid.c                                  |   2 +-
kernel/rcu/Kconfig                            |  19 ++
kernel/rcu/rcu.h                              |  12 +
kernel/rcu/rcu_segcblist.c                    |  23 +-
kernel/rcu/rcu_segcblist.h                    |   8 +
kernel/rcu/rcuscale.c                         |  74 ++++-
kernel/rcu/rcutorture.c                       |  60 +++-
kernel/rcu/tree.c                             | 187 ++++++++----
kernel/rcu/tree.h                             |  13 +-
kernel/rcu/tree_nocb.h                        | 282 +++++++++++++++---
kernel/time/posix-timers.c                    |   2 +-
lib/radix-tree.c                              |   2 +-
lib/xarray.c                                  |   2 +-
mm/slab.h                                     |  54 ++--
mm/slub.c                                     |  20 +-
net/core/dst.c                                |   2 +-
security/security.c                           |   2 +-
security/selinux/avc.c                        |   4 +-
.../selftests/rcutorture/configs/rcu/CFLIST   |   1 +
.../selftests/rcutorture/configs/rcu/TREE11   |  18 ++
.../rcutorture/configs/rcu/TREE11.boot        |   8 +
32 files changed, 783 insertions(+), 153 deletions(-)
create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TREE11
create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TREE11.boot

--
2.37.2.789.g6183377224-goog

