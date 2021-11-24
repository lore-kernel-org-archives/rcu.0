Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC5CC433F5
	for <rcu@archiver.kernel.org>; Wed, 24 Nov 2021 11:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241671AbhKXLGb (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 24 Nov 2021 06:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241669AbhKXLGa (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 24 Nov 2021 06:06:30 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0D0C061574;
        Wed, 24 Nov 2021 03:03:20 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id t26so6110201lfk.9;
        Wed, 24 Nov 2021 03:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3N50/V+FAPxYOLPbnr4c7VJsA7/kRWtvGKg6E6hbmCk=;
        b=ebdLj1Vp/Jmn0r84mzENAbeb8Bo+vp03OogPVQtLqDNwTMf3gUd9B02hJNlzDNyg5d
         AIY2hNld3XLebU4S+1EBPqVAk9WBFR4Qysut6s2TmwfhEm1rqOZU6bSqDJm0YDaz2CO0
         PPg9/Fpxs3K0Sa1fWHBHAkQNz3GzR4Dh8bANqO0pKjGJEcESI3Bp3hmH3Kl5YQABNw9l
         ShKoqJ0ELhmFjBvU7G222Yfmv8rKJyN/uXSE0lfQHejfMcaMCOEjxLs43wszWOkExcM4
         QFHws6r1512OkYtWHlSbiD/NVGXz13g90O0Zx1bqE52CaEvxznO2EV2VLOUeCSYWw3G/
         4PBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3N50/V+FAPxYOLPbnr4c7VJsA7/kRWtvGKg6E6hbmCk=;
        b=dL4iKzuyW9ejsocF+q5OGLf4jyklRsI31IW4oXenWKCemivp/8LQjhqD1nvrVJfO8E
         lm0TZIelmG5E9LiO+OUWq+Lzekar/mmlqla9/KPPQsn4avOtZMfi5X3/AAhgo9mG/89z
         vuOvPyalE/hIxh47dsgesYlvlN7ZcmRMYdM1wXxvzzzgdceSnHyS7AFRZKRzAlZvISK4
         yhSCcLLCuQQ4eU4XsjqFGI/S9rTNNJMkr7ljasEogwWue8vv7j5z80e+tyoVuLoXNgq9
         2d15QymY3O1lVlqlRRyp4uMVyPqPzz6sp0HPpRp29sxfL4pTlWQYenCC6ES7OQTn0vTH
         dQsA==
X-Gm-Message-State: AOAM530FsP3YJmlj0fwUvhh41RLZF8soMtsYz/KfKB0KwUBHWCG83/Wa
        MwAESG11dUM85nHEqhWgCoOQBNORNZMOPnVf
X-Google-Smtp-Source: ABdhPJz4VHlL3F56HzgKCa1QmfLtWMUe01Ozb9a0ShiOun3PJ7owmFumsfHa8mQIHHSM2Z3tAd4eqQ==
X-Received: by 2002:a05:6512:3404:: with SMTP id i4mr13418996lfr.689.1637751797993;
        Wed, 24 Nov 2021 03:03:17 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id u22sm1579907lff.118.2021.11.24.03.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 03:03:17 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH 0/9] Switch to single argument kvfree_rcu() API
Date:   Wed, 24 Nov 2021 12:02:59 +0100
Message-Id: <20211124110308.2053-1-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi!

This is an attempt to replace places in the Linux kernel for using
single argument of kvfree_rcu() API. In short, a single argument
API allows something like below:

<snip>
    void *ptr = kvmalloc(some_bytes, GFP_KERNEL);
        if (ptr)
            kvfree_rcu(ptr);
<snip>

i.e. to free a pointer after a grace period of object that does not
have any rcu_head field inside its structure. Due to lacking of such
mechanism users just do:

<snip>
    synchronize_rcu();
    kfree(p);
<snip>

if they do not want to have an rcu_head element in their data. Thus
this series replaces mentioned places to go with the single argument API.

It is based on the 5.16.0-rc2 also it can be applied on Paul's latest RCU
"dev" branch. 

Thanks!

Uladzislau Rezki (2):
  ext4: Switch to kvfree_rcu() API
  fs: nfs: sysfs: Switch to kvfree_rcu() API

Uladzislau Rezki (Sony) (7):
  ext4: Replace ext4_kvfree_array_rcu() by kvfree_rcu() API
  drivers: Switch to kvfree_rcu() API
  x86/mm: Switch to kvfree_rcu() API
  net/tipc: Switch to kvfree_rcu() API
  net/core: Switch to kvfree_rcu() API
  module: Switch to kvfree_rcu() API
  tracing: Switch to kvfree_rcu() API

 arch/x86/mm/mmio-mod.c                        |  6 ++--
 drivers/block/drbd/drbd_nl.c                  |  9 ++----
 drivers/block/drbd/drbd_receiver.c            |  6 ++--
 drivers/block/drbd/drbd_state.c               |  3 +-
 drivers/block/rnbd/rnbd-srv.c                 |  3 +-
 drivers/crypto/nx/nx-common-pseries.c         |  3 +-
 drivers/infiniband/hw/hfi1/sdma.c             |  3 +-
 drivers/ipack/carriers/tpci200.c              |  3 +-
 drivers/mfd/dln2.c                            |  6 ++--
 drivers/misc/vmw_vmci/vmci_context.c          |  6 ++--
 drivers/misc/vmw_vmci/vmci_event.c            |  3 +-
 .../net/ethernet/chelsio/cxgb4/cxgb4_main.c   |  3 +-
 .../net/ethernet/mellanox/mlx5/core/en/qos.c  |  3 +-
 .../ethernet/mellanox/mlx5/core/fpga/tls.c    |  3 +-
 drivers/net/ethernet/mellanox/mlxsw/core.c    |  3 +-
 drivers/scsi/device_handler/scsi_dh_alua.c    |  3 +-
 drivers/scsi/device_handler/scsi_dh_rdac.c    |  3 +-
 drivers/staging/fwserial/fwserial.c           |  3 +-
 fs/ext4/ext4.h                                |  1 -
 fs/ext4/mballoc.c                             |  2 +-
 fs/ext4/resize.c                              | 31 ++-----------------
 fs/ext4/super.c                               |  5 ++-
 fs/nfs/sysfs.c                                |  7 ++---
 kernel/module.c                               |  3 +-
 kernel/trace/trace_osnoise.c                  |  3 +-
 kernel/trace/trace_probe.c                    |  3 +-
 net/core/sysctl_net_core.c                    |  3 +-
 net/tipc/crypto.c                             |  3 +-
 28 files changed, 37 insertions(+), 96 deletions(-)

-- 
2.30.2

