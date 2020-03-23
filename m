Return-Path: <SRS0=+8aq=5I=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4554AC4332B
	for <rcu@archiver.kernel.org>; Mon, 23 Mar 2020 11:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09A9B206F9
	for <rcu@archiver.kernel.org>; Mon, 23 Mar 2020 11:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2L7i/q0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbgCWLgg (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 23 Mar 2020 07:36:36 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38811 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728172AbgCWLgf (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 23 Mar 2020 07:36:35 -0400
Received: by mail-lj1-f196.google.com with SMTP id w1so14118967ljh.5;
        Mon, 23 Mar 2020 04:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FhhZGCEqFSQlZZpCymNYzwJIUYAa9ackcZ71n1wRacs=;
        b=X2L7i/q0OdGizDsMgr6Gk7TUlPAX8wTytluqu4+YB7+eBXKKqaSu8+6MmhAHcJJPkn
         1bPZn6Z0apG79YYUcQdDtgNMWQVranf8/88QGes94jFImnQiyDhpCCV12pBSZkng5jTp
         oOGEGz8pYPD0f7ENho248WwFfX1n7IEBBVAD0unE1h9OJNn8gBCYhIcz+dmSZ2N/R4UA
         qe5lqD3vboQ+r61opbDko6tafK3iL8k53U3sEFNQjk5F+H2netMivsCU4wEarbL4+6XX
         RZCwXsVVUfN8JS2kNBOYh4FL7Wbe1fB5O3WhEMaTMgFzG4+IxQfjyT+8dgHlmU0EqB25
         n1pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FhhZGCEqFSQlZZpCymNYzwJIUYAa9ackcZ71n1wRacs=;
        b=McGj0NnlsGLKSijV7sAJzJVS/i5p553Elb6dDo9wHh7Ma611x0syKTX8DyIPNAst1/
         QohTogLsLghasl/x/UAW5tGmcXWU9uRM4z/8hqBY7vfG+1D5oTLoWj71axqanMGkiXAe
         CYIG6kzLc5qRsiDUMI5U6MWuw87X1obFxtZsMS8oHeSmZoGf3To/fTrv/6bN4tSydsyo
         mAiII11hkpI3RxwKBMimJM6hwHelEtZqH7d+DGHb19AKwZzKzatqFWKWT8br0yW3jUGJ
         QalW1uXIxB5ddvYHZixY6Skx82ph6fn3pj/AJt0YYzs+Oe5xZvU+in82E6+Vz6Epq9OV
         i/7A==
X-Gm-Message-State: ANhLgQ1zuLCurkwjfwQErSsLmRXJy1XwQbbN5ZSosuxUBrBq+1a1f+u2
        12+1PHLjKG+sXctJ/X7L+XUQQCVzabY=
X-Google-Smtp-Source: ADFU+vvEtCsZKxAOj4D7FjJD1eFU3j3ni3gLtcqQPAPhIr2LkbDnwJOqVHX2StnYdEInhsa/VvEA7w==
X-Received: by 2002:a2e:9797:: with SMTP id y23mr13494219lji.183.1584963389645;
        Mon, 23 Mar 2020 04:36:29 -0700 (PDT)
Received: from localhost.localdomain (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id r23sm8079268lfi.89.2020.03.23.04.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 04:36:29 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     RCU <rcu@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH 0/7] Headless support in the kvfree_rcu()
Date:   Mon, 23 Mar 2020 12:36:14 +0100
Message-Id: <20200323113621.12048-1-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Motivation.
We had some discussions about having possibility to kvfree() an
object that does not contain any rcu_head inside its allocated
memory. Basically to have a simple interface like:

<snip>
    void *ptr = kvmalloc(some_bytes, GFP_KERNEL);
        if (ptr)
            kvfree_rcu(ptr);
<snip>

For example, please have a look at recent ext4 topic
    https://lkml.org/lkml/2020/2/19/1372

due to lack of the interface that is in question, the
ext4 specific workaround has been introduced to kvfree()
after a grace period:

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

Also, as Joel Fernandes mentioned and proposed we also
can have kfree_rcu() headless variant. Actually with this
series it is capable of doing that, but there is missing
one thing. The kfree_rcu() macro is eligible to be called
with two arguments only. So it should be updated similar
way as it has been done for kvfree_rcu().

In that case we can update many places in the kernel where
people do not embed the rcu_head into their stuctures for
some reason and do like:

<snip>
    synchronize_rcu();
    kfree(p);
<snip>

<snip>
urezki@pc636:~/data/ssd/coding/linux-rcu$ find ./ -name "*.c" | xargs grep -C 1 -rn "synchronize_rcu" | grep kfree
./arch/x86/mm/mmio-mod.c-314-           kfree(found_trace);
./kernel/module.c-3910- kfree(mod->args);
./kernel/trace/ftrace.c-5078-                   kfree(direct);
./kernel/trace/ftrace.c-5155-                   kfree(direct);
./kernel/trace/trace_probe.c-1087-      kfree(link);
./fs/nfs/sysfs.c-113-           kfree(old);
./fs/ext4/super.c-1701- kfree(old_qname);
./net/ipv4/gre.mod.c-36-        { 0xfc3fcca2, "kfree_skb" },
./net/core/sysctl_net_core.c-143-                               kfree(cur);
./drivers/crypto/nx/nx-842-pseries.c-1010-      kfree(old_devdata);
./drivers/misc/vmw_vmci/vmci_context.c-692-             kfree(notifier);
./drivers/misc/vmw_vmci/vmci_event.c-213-       kfree(s);
./drivers/infiniband/core/device.c:2162:                         * synchronize_rcu before the netdev is kfreed, so we
./drivers/infiniband/hw/hfi1/sdma.c-1337-       kfree(dd->per_sdma);
./drivers/net/ethernet/myricom/myri10ge/myri10ge.c-3582-        kfree(mgp->ss);
./drivers/net/ethernet/myricom/myri10ge/myri10ge.mod.c-156-     { 0x37a0cba, "kfree" },
./drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c:286:       synchronize_rcu(); /* before kfree(flow) */
./drivers/net/ethernet/mellanox/mlxsw/core.c-1504-      kfree(rxl_item);
./drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c-6648- kfree(adapter->mbox_log);
./drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c-6650- kfree(adapter);
./drivers/block/drbd/drbd_receiver.c-3804-      kfree(old_net_conf);
./drivers/block/drbd/drbd_receiver.c-4176-                      kfree(old_disk_conf);
./drivers/block/drbd/drbd_state.c-2074-         kfree(old_conf);
./drivers/block/drbd/drbd_nl.c-1689-    kfree(old_disk_conf);
./drivers/block/drbd/drbd_nl.c-2522-    kfree(old_net_conf);
./drivers/block/drbd/drbd_nl.c-2935-            kfree(old_disk_conf);
./drivers/mfd/dln2.c-178-               kfree(i);
./drivers/staging/fwserial/fwserial.c-2122-     kfree(peer);
<snip>

Uladzislau Rezki (Sony) (7):
  rcu/tree: simplify KFREE_BULK_MAX_ENTR macro
  rcu/tree: maintain separate array for vmalloc ptrs
  rcu/tree: introduce expedited_drain flag
  rcu/tree: support reclaim for head-less object
  rcu/tiny: move kvfree_call_rcu() out of header
  rcu/tiny: support reclaim for head-less object
  rcu: support headless variant in the kvfree_rcu()

 include/linux/rcupdate.h |  38 ++++-
 include/linux/rcutiny.h  |   6 +-
 kernel/rcu/tiny.c        | 161 +++++++++++++++++++++
 kernel/rcu/tree.c        | 294 ++++++++++++++++++++++++++++-----------
 4 files changed, 407 insertions(+), 92 deletions(-)

-- 
2.20.1

