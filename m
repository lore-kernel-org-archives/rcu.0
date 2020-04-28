Return-Path: <SRS0=nxXf=6M=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCC9C83000
	for <rcu@archiver.kernel.org>; Tue, 28 Apr 2020 20:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 761002137B
	for <rcu@archiver.kernel.org>; Tue, 28 Apr 2020 20:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5kQXV+8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgD1U7Z (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 28 Apr 2020 16:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726284AbgD1U7Y (ORCPT
        <rfc822;rcu@vger.kernel.org>); Tue, 28 Apr 2020 16:59:24 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647DAC03C1AC;
        Tue, 28 Apr 2020 13:59:24 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id a21so188927ljj.11;
        Tue, 28 Apr 2020 13:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ToRrXq0h+MaIe9sAtKeR8JTVBkLIVLUGFF5zgLnrWbE=;
        b=Z5kQXV+8tkklTAuR5SI1mnHMcTTLiyrBbuwhPBZ+eRzQdGmjAWBHuMjWXtMspoZ5e+
         t5qlAcc2T7SNDzLJ73Uv9q3pWoITYvf/jDHykamSrEb/sJh8kVvfU6dPwf7nzEa/BudV
         UUJcKJU7Ua5XI/A02JF4hmmCcfzN7FkNDOrQrr5htpFGT/6kOGjrE3GQ8SrCQyWuFa4r
         MR6yjODmqOAQdqeswobSP0j2LNqECRnELdxYcLJbxfOmeXU4RhqTxT4x52Gt2eKoblh5
         9+bY787BLoeOTZrLtAsblH1Q+Z2s4LN9aj7IXy2Ey2zmqLeJuTum7eYtR5AFU995qZKF
         yPJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ToRrXq0h+MaIe9sAtKeR8JTVBkLIVLUGFF5zgLnrWbE=;
        b=aqEax/eeD5A5CCIruDZeaP08ymbkTAxgE3bnIiq1/VmRKto1Pw2GoEdcOxhjcnTnSr
         Fx3iJ2J/hJwS9JJamvBEbG5+4s6d5SdwAh8TN2bPqv3q2JK+/87x8+Q6F6BFEFDggwDi
         fo+oB1dYUROcH5+oAy5qx3W6L7zBCCfl//lm7UcmMBSqjfTWclxUT+lYZ5neIGf0VRfy
         fjB7Yq4nNWIjtxlDj2/r5UfnYglTMlXmLGQY8fMJuroB309bQNZtny1S47JUQlSjoXOz
         S4N/5HVCKOqfsbddFVRZbtkdp3tStECQh187LVPaXb7xJFamc0Qe9w204ZkRtwErdbaB
         Zalw==
X-Gm-Message-State: AGi0PuYYf2pkcOHjhwmK1ExUdgEeou/NxazDvoIby71WLDMycbnyix7c
        HruRn/wXXbyHl6JrY/GsQiXwd4ViiKkcGA==
X-Google-Smtp-Source: APiQypKTGjtBGw5u0Ua2elBmcIbrbUs22iIyVyOyKgKBKPCo/mdX0gwKSUUXa/EMkhV8jKwaJGtBDg==
X-Received: by 2002:a2e:870d:: with SMTP id m13mr18464164lji.64.1588107562381;
        Tue, 28 Apr 2020 13:59:22 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id z21sm295483ljh.42.2020.04.28.13.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 13:59:21 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH 00/24] Introduce kvfree_rcu(1 or 2 arguments)
Date:   Tue, 28 Apr 2020 22:58:39 +0200
Message-Id: <20200428205903.61704-1-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Motivation
----------
There were some discussions and demand in having kvfree_rcu()
interface for different purposes. Basically to have a simple
interface like:

<snip>
    void *ptr = kvmalloc(some_bytes, GFP_KERNEL);
        if (ptr)
            kvfree_rcu(ptr);
<snip>

For example, please have a look at ext4 discussion here:
    https://lkml.org/lkml/2020/2/19/1372

due to lack of the interface that is in question, the ext4 specific
workaround has been introduced, to kvfree() after a grace period:

<snip>
void ext4_kvfree_array_rcu(void *to_free)
{
	struct ext4_rcu_ptr *ptr = kzalloc(sizeof(*ptr), GFP_KERNEL);

	if (ptr) {
		ptr->ptr = to_free;
		call_rcu(&ptr->rcu, ext4_rcu_ptr_callback);
		return;
	}
	synchronize_rcu();
	kvfree(ptr);
}
<snip>

there are also similar places there which could be replaced by the new
interface, that is much more efficient then just call synchronize_rcu()
and release a memory.

Please have a look at another places in the kernel where people do not
embed the rcu_head into their stuctures for some reason and do like:

<snip>
    synchronize_rcu();
    kfree(p);
<snip>

<snip>
urezki@pc638:~/data/coding/linux-rcu.git$ find ./ -name "*.c" | xargs grep -C 1 -rn "synchronize_rcu" | grep kfree
./fs/nfs/sysfs.c-113-           kfree(old);
./fs/ext4/super.c-1708- kfree(old_qname);
./kernel/trace/ftrace.c-5079-                   kfree(direct);
./kernel/trace/ftrace.c-5156-                   kfree(direct);
./kernel/trace/trace_probe.c-1087-      kfree(link);
./kernel/module.c-3910- kfree(mod->args);
./net/core/sysctl_net_core.c-143-                               kfree(cur);
./arch/x86/mm/mmio-mod.c-314-           kfree(found_trace);
./drivers/mfd/dln2.c-183-               kfree(i);
./drivers/block/drbd/drbd_state.c-2074-         kfree(old_conf);
./drivers/block/drbd/drbd_nl.c-1689-    kfree(old_disk_conf);
./drivers/block/drbd/drbd_nl.c-2522-    kfree(old_net_conf);
./drivers/block/drbd/drbd_nl.c-2935-            kfree(old_disk_conf);
./drivers/block/drbd/drbd_receiver.c-3805-      kfree(old_net_conf);
./drivers/block/drbd/drbd_receiver.c-4177-                      kfree(old_disk_conf);
./drivers/ipack/carriers/tpci200.c-189- kfree(slot_irq);
./drivers/crypto/nx/nx-842-pseries.c-1010-      kfree(old_devdata);
./drivers/net/ethernet/myricom/myri10ge/myri10ge.c-3583-        kfree(mgp->ss);
./drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c:286:       synchronize_rcu(); /* before kfree(flow) */
./drivers/net/ethernet/mellanox/mlxsw/core.c-1574-      kfree(rxl_item);
./drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c-6642- kfree(adapter->mbox_log);
./drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c-6644- kfree(adapter);
./drivers/infiniband/hw/hfi1/sdma.c-1337-       kfree(dd->per_sdma);
./drivers/infiniband/core/device.c:2164:                         * synchronize_rcu before the netdev is kfreed, so we
./drivers/misc/vmw_vmci/vmci_context.c-692-             kfree(notifier);
./drivers/misc/vmw_vmci/vmci_event.c-213-       kfree(s);
./drivers/staging/fwserial/fwserial.c-2122-     kfree(peer);
urezki@pc638:~/data/coding/linux-rcu.git$
<snip>

so all of it can be replaced by the introduced interface and that
is actually aim and motivation. All that can replaced by the single
kvfree_rcu() logic.

As for double argument of the kvfree_rcu() we have only one user
so far, it is "mm/list_lru.c". But it costs nothing to add it.

Description
-----------
This small series introduces kvfree_rcu() macro that is used
for free memory after a grace period. It can be called either
with one or two arguments. kvfree_rcu() as it derives from its
name can handle two types of pointers, SLAB and vmalloc ones.

As a result we get two ways how to use kvfree_rcu() macro, see
below two examples.

a) kvfree_rcu(ptr, rhf);
    struct X {
        struct rcu_head rhf;
        unsigned char data[100];
    };

    void *ptr = kvmalloc(sizeof(struct X), GFP_KERNEL);
    if (ptr)
        kvfree_rcu(ptr, rhf);

b) kvfree_rcu(ptr);
    void *ptr = kvmalloc(some_bytes, GFP_KERNEL);
    if (ptr)
        kvfree_rcu(ptr);

Last one, we name it headless variant, only needs one argument,
means it does not require any rcu_head to be present within the
type of ptr. There is a restriction the (b) context has to fall
into might_sleep() annotation. To check that, please activate
the CONFIG_DEBUG_ATOMIC_SLEEP option in your kernel.

This series is based on:
git://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git
"origin/rcu/dev" branch, what is the same as Paul's almost
latest dev.2020.04.13c branch.

Appreciate for any comments and feedback.

Joel Fernandes (Google) (5):
  rcu/tree: Keep kfree_rcu() awake during lock contention
  rcu/tree: Skip entry into the page allocator for PREEMPT_RT
  rcu/tree: Use consistent style for comments
  rcu/tree: Simplify debug_objects handling
  rcu/tree: Make kvfree_rcu() tolerate any alignment

Sebastian Andrzej Siewior (1):
  rcu/tree: Use static initializer for krc.lock

Uladzislau Rezki (Sony) (18):
  rcu/tree: Repeat the monitor if any free channel is busy
  rcu/tree: Simplify KFREE_BULK_MAX_ENTR macro
  rcu/tree: move locking/unlocking to separate functions
  rcu/tree: cache specified number of objects
  rcu/tree: add rcutree.rcu_min_cached_objs description
  rcu/tree: Maintain separate array for vmalloc ptrs
  rcu/tiny: support vmalloc in tiny-RCU
  rcu: Rename rcu_invoke_kfree_callback/rcu_kfree_callback
  rcu: Rename __is_kfree_rcu_offset() macro
  rcu: Rename kfree_call_rcu() to the kvfree_call_rcu().
  mm/list_lru.c: Rename kvfree_rcu() to local variant
  rcu: Introduce 2 arg kvfree_rcu() interface
  mm/list_lru.c: Remove kvfree_rcu_local() function
  rcu/tree: Support reclaim for head-less object
  rcu/tiny: move kvfree_call_rcu() out of header
  rcu/tiny: support reclaim for head-less object
  rcu: Introduce 1 arg kvfree_rcu() interface
  lib/test_vmalloc.c: Add test cases for kvfree_rcu()

 .../admin-guide/kernel-parameters.txt         |   8 +
 include/linux/rcupdate.h                      |  53 +-
 include/linux/rcutiny.h                       |   6 +-
 include/linux/rcutree.h                       |   2 +-
 include/trace/events/rcu.h                    |   8 +-
 kernel/rcu/tiny.c                             | 168 ++++++-
 kernel/rcu/tree.c                             | 454 +++++++++++++-----
 lib/test_vmalloc.c                            | 103 +++-
 mm/list_lru.c                                 |  11 +-
 9 files changed, 662 insertions(+), 151 deletions(-)

-- 
2.20.1
