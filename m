Return-Path: <SRS0=2Yb6=Q6=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240D8C43381
	for <rcu@archiver.kernel.org>; Sat, 23 Feb 2019 06:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDC2220652
	for <rcu@archiver.kernel.org>; Sat, 23 Feb 2019 06:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="LXf4B9ji"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbfBWGfe (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 23 Feb 2019 01:35:34 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40595 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbfBWGey (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 23 Feb 2019 01:34:54 -0500
Received: by mail-qt1-f193.google.com with SMTP id j36so5109732qta.7
        for <rcu@vger.kernel.org>; Fri, 22 Feb 2019 22:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+VRwkLma4QHsLodLyqLqscrFLAElLwMuFYkHuZgYCiA=;
        b=LXf4B9jiVhDDmWHqmpX8sitFrnlfo5OGBPgxZMG1SG9dPgcG05UwP/0ab87QJca35A
         +5vX47xZXK/bvlYBPDse0FJpr4WEcj+RtEPX3feM0h5vddYnqNxNRh1Wj7XVR3VJINey
         NNLEqhrf5Bc1rXkGgXSBIsTOm2/s0liaYt+t8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+VRwkLma4QHsLodLyqLqscrFLAElLwMuFYkHuZgYCiA=;
        b=K1ELmZN3zx9p1SvWaFZs5n7/DMObXTzT/Qrm99YMNPnFsvPBG5m7ii08RbwknFEpjb
         khluVLV6zPGD2Csw3/cnGwN3ymPk/eJo5SlUr6FlPPQ1dqBoDBtgNlwmsukYtgocTJAV
         TFoia1UtfyZrbW65GbDSRdX3v4Y0W9jCiFchVdgLAtGkxV19fhArnW0hY5jE0tGbny1Q
         4yccm958fcrlYn/XDru0cwWw8XeWauvvyf7x96Ub4mwbEhMMwCI+nECVhd3MIsMRMuG3
         IbkNwW0r8xh9WS6E51rjipuCSuNVE8SVNrtyUB/o5Nazejz3rp0tcCIGA00ARxZ86Ma1
         +aFA==
X-Gm-Message-State: AHQUAuZuD3TndNjqrcN5E64Mqd0tI3mfsz9d1x6NO0/OyhVEWM0thh4M
        SFGUe1dUE3NTfvL+FR/4cXQ7LA==
X-Google-Smtp-Source: AHgI3IahEVRnoZ+AHkPdERWnSNKPgReNQYpi0yxVo8XFjoaLgTIuIzDAlYYdutedD2WueyS54r/lCw==
X-Received: by 2002:a0c:92ec:: with SMTP id c41mr6220040qvc.158.1550903693796;
        Fri, 22 Feb 2019 22:34:53 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id d32sm2189408qtc.88.2019.02.22.22.34.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 22:34:52 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ingo Molnar <mingo@redhat.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>, keescook@chromium.org,
        kernel-hardening@lists.openwall.com, kernel-team@android.com,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        netdev@vger.kernel.org, "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Quentin Perret <quentin.perret@arm.com>, rcu@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        xdp-newbies@vger.kernel.org, Yonghong Song <yhs@fb.com>
Subject: [PATCH v2 2/6] ixgbe: Fix incorrect RCU API usage
Date:   Sat, 23 Feb 2019 01:34:30 -0500
Message-Id: <20190223063434.6793-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <20190223063434.6793-1-joel@joelfernandes.org>
References: <20190223063434.6793-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Recently, I added an RCU annotation check in rcu_assign_pointer. This
caused a sparse error to be reported by the ixgbe driver.

Further looking, it seems the adapter->xdp_prog pointer is not annotated
with __rcu. Annonating it fixed the error, but caused a bunch of other
warnings.

This patch tries to fix all warnings by using RCU API properly. This
makes sense to do because not using RCU properly can result in various
hard to find bugs. This is a best effort fix and is only build tested.
The sparse errors and warnings go away with the change. I request
maintainers / developers in this area to review / test it properly.

The sparse error fixed is:
ixgbe_main.c:10256:25: error: incompatible types in comparison expression

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  4 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 15 ++++++++++-----
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 08d85e336bd4..3b14daf27516 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -311,7 +311,7 @@ struct ixgbe_ring {
 	struct ixgbe_ring *next;	/* pointer to next ring in q_vector */
 	struct ixgbe_q_vector *q_vector; /* backpointer to host q_vector */
 	struct net_device *netdev;	/* netdev ring belongs to */
-	struct bpf_prog *xdp_prog;
+	struct bpf_prog __rcu *xdp_prog;
 	struct device *dev;		/* device for DMA mapping */
 	void *desc;			/* descriptor ring memory */
 	union {
@@ -560,7 +560,7 @@ struct ixgbe_adapter {
 	unsigned long active_vlans[BITS_TO_LONGS(VLAN_N_VID)];
 	/* OS defined structs */
 	struct net_device *netdev;
-	struct bpf_prog *xdp_prog;
+	struct bpf_prog __rcu *xdp_prog;
 	struct pci_dev *pdev;
 	struct mii_bus *mii_bus;
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index daff8183534b..408a312aa6ba 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2199,7 +2199,7 @@ static struct sk_buff *ixgbe_run_xdp(struct ixgbe_adapter *adapter,
 	u32 act;
 
 	rcu_read_lock();
-	xdp_prog = READ_ONCE(rx_ring->xdp_prog);
+	xdp_prog = rcu_dereference(rx_ring->xdp_prog);
 
 	if (!xdp_prog)
 		goto xdp_out;
@@ -6547,7 +6547,7 @@ int ixgbe_setup_rx_resources(struct ixgbe_adapter *adapter,
 			     rx_ring->queue_index) < 0)
 		goto err;
 
-	rx_ring->xdp_prog = adapter->xdp_prog;
+	rcu_assign_pointer(rx_ring->xdp_prog, adapter->xdp_prog);
 
 	return 0;
 err:
@@ -10246,7 +10246,8 @@ static int ixgbe_xdp_setup(struct net_device *dev, struct bpf_prog *prog)
 	if (nr_cpu_ids > MAX_XDP_QUEUES)
 		return -ENOMEM;
 
-	old_prog = xchg(&adapter->xdp_prog, prog);
+	old_prog = rcu_access_pointer(adapter->xdp_prog);
+	rcu_assign_pointer(adapter->xdp_prog, prog);
 
 	/* If transitioning XDP modes reconfigure rings */
 	if (!!prog != !!old_prog) {
@@ -10271,13 +10272,17 @@ static int ixgbe_xdp_setup(struct net_device *dev, struct bpf_prog *prog)
 static int ixgbe_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 {
 	struct ixgbe_adapter *adapter = netdev_priv(dev);
+	struct bpf_prog *prog;
 
 	switch (xdp->command) {
 	case XDP_SETUP_PROG:
 		return ixgbe_xdp_setup(dev, xdp->prog);
 	case XDP_QUERY_PROG:
-		xdp->prog_id = adapter->xdp_prog ?
-			adapter->xdp_prog->aux->id : 0;
+		rcu_read_lock();
+		prog = rcu_dereference(adapter->xdp_prog);
+		xdp->prog_id = prog ? prog->aux->id : 0;
+		rcu_read_unlock();
+
 		return 0;
 	case XDP_QUERY_XSK_UMEM:
 		return ixgbe_xsk_umem_query(adapter, &xdp->xsk.umem,
-- 
2.21.0.rc0.258.g878e2cd30e-goog

