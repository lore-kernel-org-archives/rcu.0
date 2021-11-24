Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC39C43217
	for <rcu@archiver.kernel.org>; Wed, 24 Nov 2021 11:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241722AbhKXLGn (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 24 Nov 2021 06:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241691AbhKXLGf (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 24 Nov 2021 06:06:35 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1164AC06173E;
        Wed, 24 Nov 2021 03:03:26 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id bu18so6310864lfb.0;
        Wed, 24 Nov 2021 03:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RtTNojmBssUuUZ61QzfgNXLUODPWBGl32aK5nlnkrC0=;
        b=XFX8CGaiOT5u3WNpMJfdkgxsez0N9IpYSHFMYiOhEKHWDCxTp0VuiKRuxbQ3uV/ubo
         9vSzdF6QgZN34uahItJheTgjTk4SVadulcqZkekkRB1O6VplzHIAQoXfiIuO58U7RgRO
         C95PgwKT5PzXEzDhhl3X98xNZOw69sGx9RmSovF2UDc+uI00alxvJunbauSyKlSFD2pS
         uQsdCxs0mBmhxwbo3dhTrNrcL0s0m25jyNwtUWEFQwD7xHP9DxShczBKQS26Kw+CgpHT
         wDlA9OlhPSoZ4kN0EAkdDw5BkHhqWvdEi6ABts6YJ6T6KKq2AKaYe5X4BP3+HLAiKb08
         ixCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RtTNojmBssUuUZ61QzfgNXLUODPWBGl32aK5nlnkrC0=;
        b=mt5qqge5LGzXp5He3/z95HtMCgC6SgckGLXmSEbq1rUZjWGsyi9Z2tO0mcO48kiHgO
         y9ESu3McMwOVueMaNx2a9yRU+MtkrQRJESOkKeB9qV9OYtSKt3Cj8NSrUqy7eK89FqGZ
         sWnX9m1gec5xPBBy2rbXR2lcB+wLJCaaMSfM4Jy7/ywUhSNtkWO8q1Ic0lN8oCsB5sN2
         dYAQp8CnHJVVrnTgblNsqFRtfmQCLzoZu9OYvxb2fb2OVJyCyi0s2MWtnCTCGdYgauVf
         TT5ZynqGDQjBOPqKJqajhNqt/SMp9hZMMjuetG4rifEAcKExNyw8QdMEmgfEI2AEJfHu
         Pxig==
X-Gm-Message-State: AOAM531bMZ4qwCmklGQ1mHdu55/H+4mr0qO6aS+RhXNAldqLTgSDDdKo
        o0/r15s0DDYxBYsrIiFMTSgLsDhs8TKhtrNt
X-Google-Smtp-Source: ABdhPJzOArtYqI9esdcVujBYUQYavBG/tiu9kmYbdhkEIreO7ZJD3FBLJqhZ8/4Uxm2cVGxbx2Q2NA==
X-Received: by 2002:a05:6512:10cb:: with SMTP id k11mr13384534lfg.534.1637751802707;
        Wed, 24 Nov 2021 03:03:22 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id u22sm1579907lff.118.2021.11.24.03.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 03:03:22 -0800 (PST)
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
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jorgen Hansen <jhansen@vmware.com>,
        Raju Rangoju <rajur@chelsio.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Boris Pismenny <borisp@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4/9] drivers: Switch to kvfree_rcu() API
Date:   Wed, 24 Nov 2021 12:03:03 +0100
Message-Id: <20211124110308.2053-5-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211124110308.2053-1-urezki@gmail.com>
References: <20211124110308.2053-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Instead of invoking a synchronize_rcu() to free a pointer
after a grace period we can directly make use of new API
that does the same but in more efficient way.

CC: Philipp Reisner <philipp.reisner@linbit.com>
CC: "Md. Haris Iqbal" <haris.iqbal@ionos.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>
CC: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
CC: Samuel Iglesias Gonsalvez <siglesias@igalia.com>
CC: Lee Jones <lee.jones@linaro.org>
CC: Jorgen Hansen <jhansen@vmware.com>
CC: Raju Rangoju <rajur@chelsio.com>
CC: Saeed Mahameed <saeedm@nvidia.com>
CC: Boris Pismenny <borisp@nvidia.com>
CC: Jiri Pirko <jiri@nvidia.com>
CC: "James E.J. Bottomley" <jejb@linux.ibm.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 drivers/block/drbd/drbd_nl.c                       | 9 +++------
 drivers/block/drbd/drbd_receiver.c                 | 6 ++----
 drivers/block/drbd/drbd_state.c                    | 3 +--
 drivers/block/rnbd/rnbd-srv.c                      | 3 +--
 drivers/crypto/nx/nx-common-pseries.c              | 3 +--
 drivers/infiniband/hw/hfi1/sdma.c                  | 3 +--
 drivers/ipack/carriers/tpci200.c                   | 3 +--
 drivers/mfd/dln2.c                                 | 6 ++----
 drivers/misc/vmw_vmci/vmci_context.c               | 6 ++----
 drivers/misc/vmw_vmci/vmci_event.c                 | 3 +--
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c    | 3 +--
 drivers/net/ethernet/mellanox/mlx5/core/en/qos.c   | 3 +--
 drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c | 3 +--
 drivers/net/ethernet/mellanox/mlxsw/core.c         | 3 +--
 drivers/scsi/device_handler/scsi_dh_alua.c         | 3 +--
 drivers/scsi/device_handler/scsi_dh_rdac.c         | 3 +--
 drivers/staging/fwserial/fwserial.c                | 3 +--
 17 files changed, 22 insertions(+), 44 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 44ccf8b4f4b2..28f4d84945fd 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1679,8 +1679,7 @@ int drbd_adm_disk_opts(struct sk_buff *skb, struct genl_info *info)
 			drbd_send_sync_param(peer_device);
 	}
 
-	synchronize_rcu();
-	kfree(old_disk_conf);
+	kvfree_rcu(old_disk_conf);
 	kfree(old_plan);
 	mod_timer(&device->request_timer, jiffies + HZ);
 	goto success;
@@ -2511,8 +2510,7 @@ int drbd_adm_net_opts(struct sk_buff *skb, struct genl_info *info)
 
 	mutex_unlock(&connection->resource->conf_update);
 	mutex_unlock(&connection->data.mutex);
-	synchronize_rcu();
-	kfree(old_net_conf);
+	kvfree_rcu(old_net_conf);
 
 	if (connection->cstate >= C_WF_REPORT_PARAMS) {
 		struct drbd_peer_device *peer_device;
@@ -2925,8 +2923,7 @@ int drbd_adm_resize(struct sk_buff *skb, struct genl_info *info)
 		new_disk_conf->disk_size = (sector_t)rs.resize_size;
 		rcu_assign_pointer(device->ldev->disk_conf, new_disk_conf);
 		mutex_unlock(&device->resource->conf_update);
-		synchronize_rcu();
-		kfree(old_disk_conf);
+		kvfree_rcu(old_disk_conf);
 		new_disk_conf = NULL;
 	}
 
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 1f740e42e457..d73a53242a75 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -3799,8 +3799,7 @@ static int receive_protocol(struct drbd_connection *connection, struct packet_in
 		drbd_info(connection, "peer data-integrity-alg: %s\n",
 			  integrity_alg[0] ? integrity_alg : "(none)");
 
-	synchronize_rcu();
-	kfree(old_net_conf);
+	kvfree_rcu(old_net_conf);
 	return 0;
 
 disconnect_rcu_unlock:
@@ -4168,8 +4167,7 @@ static int receive_sizes(struct drbd_connection *connection, struct packet_info
 
 			rcu_assign_pointer(device->ldev->disk_conf, new_disk_conf);
 			mutex_unlock(&connection->resource->conf_update);
-			synchronize_rcu();
-			kfree(old_disk_conf);
+			kvfree_rcu(old_disk_conf);
 
 			drbd_info(device, "Peer sets u_size to %lu sectors (old: %lu)\n",
 				 (unsigned long)p_usize, (unsigned long)my_usize);
diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index b8a27818ab3f..826e496821c7 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -2071,8 +2071,7 @@ static int w_after_conn_state_ch(struct drbd_work *w, int unused)
 		conn_free_crypto(connection);
 		mutex_unlock(&connection->resource->conf_update);
 
-		synchronize_rcu();
-		kfree(old_conf);
+		kvfree_rcu(old_conf);
 	}
 
 	if (ns_max.susp_fen) {
diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index aafecfe97055..373dedd499b4 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -808,8 +808,7 @@ static int process_msg_open(struct rnbd_srv_session *srv_sess,
 
 free_srv_sess_dev:
 	xa_erase(&srv_sess->index_idr, srv_sess_dev->device_id);
-	synchronize_rcu();
-	kfree(srv_sess_dev);
+	kvfree_rcu(srv_sess_dev);
 srv_dev_put:
 	if (open_msg->access_mode != RNBD_ACCESS_RO) {
 		mutex_lock(&srv_dev->lock);
diff --git a/drivers/crypto/nx/nx-common-pseries.c b/drivers/crypto/nx/nx-common-pseries.c
index 4e304f6081e4..3faf30120ac9 100644
--- a/drivers/crypto/nx/nx-common-pseries.c
+++ b/drivers/crypto/nx/nx-common-pseries.c
@@ -1061,8 +1061,7 @@ static int nx842_probe(struct vio_dev *viodev,
 
 	rcu_assign_pointer(devdata, new_devdata);
 	spin_unlock_irqrestore(&devdata_mutex, flags);
-	synchronize_rcu();
-	kfree(old_devdata);
+	kvfree_rcu(old_devdata);
 
 	of_reconfig_notifier_register(&nx842_of_nb);
 
diff --git a/drivers/infiniband/hw/hfi1/sdma.c b/drivers/infiniband/hw/hfi1/sdma.c
index 2b6c24b7b586..0a0caf7360a4 100644
--- a/drivers/infiniband/hw/hfi1/sdma.c
+++ b/drivers/infiniband/hw/hfi1/sdma.c
@@ -1292,8 +1292,7 @@ void sdma_clean(struct hfi1_devdata *dd, size_t num_engines)
 	sdma_map_free(rcu_access_pointer(dd->sdma_map));
 	RCU_INIT_POINTER(dd->sdma_map, NULL);
 	spin_unlock_irq(&dd->sde_map_lock);
-	synchronize_rcu();
-	kfree(dd->per_sdma);
+	kvfree_rcu(dd->per_sdma);
 	dd->per_sdma = NULL;
 
 	if (dd->sdma_rht) {
diff --git a/drivers/ipack/carriers/tpci200.c b/drivers/ipack/carriers/tpci200.c
index cbfdadecb23b..de29fe594022 100644
--- a/drivers/ipack/carriers/tpci200.c
+++ b/drivers/ipack/carriers/tpci200.c
@@ -180,8 +180,7 @@ static int tpci200_free_irq(struct ipack_device *dev)
 	slot_irq = tpci200->slots[dev->slot].irq;
 	/* uninstall handler */
 	RCU_INIT_POINTER(tpci200->slots[dev->slot].irq, NULL);
-	synchronize_rcu();
-	kfree(slot_irq);
+	kvfree_rcu(slot_irq);
 	mutex_unlock(&tpci200->mutex);
 	return 0;
 }
diff --git a/drivers/mfd/dln2.c b/drivers/mfd/dln2.c
index 852129ea0766..365e3e77cac4 100644
--- a/drivers/mfd/dln2.c
+++ b/drivers/mfd/dln2.c
@@ -179,10 +179,8 @@ void dln2_unregister_event_cb(struct platform_device *pdev, u16 id)
 
 	spin_unlock_irqrestore(&dln2->event_cb_lock, flags);
 
-	if (found) {
-		synchronize_rcu();
-		kfree(i);
-	}
+	if (found)
+		kvfree_rcu(i);
 }
 EXPORT_SYMBOL(dln2_unregister_event_cb);
 
diff --git a/drivers/misc/vmw_vmci/vmci_context.c b/drivers/misc/vmw_vmci/vmci_context.c
index c0b5e339d5a1..6cf3e21c7604 100644
--- a/drivers/misc/vmw_vmci/vmci_context.c
+++ b/drivers/misc/vmw_vmci/vmci_context.c
@@ -687,10 +687,8 @@ int vmci_ctx_remove_notification(u32 context_id, u32 remote_cid)
 	}
 	spin_unlock(&context->lock);
 
-	if (found) {
-		synchronize_rcu();
-		kfree(notifier);
-	}
+	if (found)
+		kvfree_rcu(notifier);
 
 	vmci_ctx_put(context);
 
diff --git a/drivers/misc/vmw_vmci/vmci_event.c b/drivers/misc/vmw_vmci/vmci_event.c
index e3436abf39f4..2100297c94ad 100644
--- a/drivers/misc/vmw_vmci/vmci_event.c
+++ b/drivers/misc/vmw_vmci/vmci_event.c
@@ -209,8 +209,7 @@ int vmci_event_unsubscribe(u32 sub_id)
 	if (!s)
 		return VMCI_ERROR_NOT_FOUND;
 
-	synchronize_rcu();
-	kfree(s);
+	kvfree_rcu(s);
 
 	return VMCI_SUCCESS;
 }
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
index dde1cf51d0ab..0619cb94f0e0 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -7190,8 +7190,7 @@ static void remove_one(struct pci_dev *pdev)
 	}
 	pci_release_regions(pdev);
 	kfree(adapter->mbox_log);
-	synchronize_rcu();
-	kfree(adapter);
+	kvfree_rcu(adapter);
 }
 
 /* "Shutdown" quiesces the device, stopping Ingress Packet and Interrupt
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c
index 50977f01a050..eaaf7e33f90b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c
@@ -388,8 +388,7 @@ static int mlx5e_qos_alloc_queues(struct mlx5e_priv *priv, struct mlx5e_channels
 		sqs = rcu_replace_pointer(chs->c[i]->qos_sqs, NULL,
 					  lockdep_is_held(&priv->state_lock));
 
-		synchronize_rcu(); /* Sync with NAPI. */
-		kvfree(sqs);
+		kvfree_rcu(sqs); /* Sync with NAPI. */
 	}
 	return -ENOMEM;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c b/drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c
index 29b7339ebfa3..e501eed7fe9f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c
@@ -253,7 +253,7 @@ static void mlx5_fpga_tls_send_teardown_cmd(struct mlx5_core_dev *mdev,
 	MLX5_SET(tls_cmd, cmd, swid, swid);
 
 	mlx5_fpga_tls_flow_to_cmd(flow, cmd);
-	kfree(flow);
+	kvfree_rcu(flow);
 
 	buf->sg[0].data = cmd;
 	buf->sg[0].size = MLX5_TLS_COMMAND_SIZE;
@@ -283,7 +283,6 @@ void mlx5_fpga_tls_del_flow(struct mlx5_core_dev *mdev, u32 swid,
 		return;
 	}
 
-	synchronize_rcu(); /* before kfree(flow) */
 	mlx5_fpga_tls_send_teardown_cmd(mdev, flow, swid, flags);
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlxsw/core.c b/drivers/net/ethernet/mellanox/mlxsw/core.c
index 3fd3812b8f31..47c29769759b 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core.c
@@ -2190,8 +2190,7 @@ void mlxsw_core_rx_listener_unregister(struct mlxsw_core *mlxsw_core,
 	if (!rxl_item)
 		return;
 	list_del_rcu(&rxl_item->list);
-	synchronize_rcu();
-	kfree(rxl_item);
+	kvfree_rcu(rxl_item);
 }
 EXPORT_SYMBOL(mlxsw_core_rx_listener_unregister);
 
diff --git a/drivers/scsi/device_handler/scsi_dh_alua.c b/drivers/scsi/device_handler/scsi_dh_alua.c
index 37d06f993b76..308246ce346a 100644
--- a/drivers/scsi/device_handler/scsi_dh_alua.c
+++ b/drivers/scsi/device_handler/scsi_dh_alua.c
@@ -1238,8 +1238,7 @@ static void alua_bus_detach(struct scsi_device *sdev)
 		kref_put(&pg->kref, release_port_group);
 	}
 	sdev->handler_data = NULL;
-	synchronize_rcu();
-	kfree(h);
+	kvfree_rcu(h);
 }
 
 static struct scsi_device_handler alua_dh = {
diff --git a/drivers/scsi/device_handler/scsi_dh_rdac.c b/drivers/scsi/device_handler/scsi_dh_rdac.c
index 66652ab409cc..dc687021ff3a 100644
--- a/drivers/scsi/device_handler/scsi_dh_rdac.c
+++ b/drivers/scsi/device_handler/scsi_dh_rdac.c
@@ -782,8 +782,7 @@ static void rdac_bus_detach( struct scsi_device *sdev )
 	}
 	spin_unlock(&list_lock);
 	sdev->handler_data = NULL;
-	synchronize_rcu();
-	kfree(h);
+	kvfree_rcu(h);
 }
 
 static struct scsi_device_handler rdac_dh = {
diff --git a/drivers/staging/fwserial/fwserial.c b/drivers/staging/fwserial/fwserial.c
index e8fa7f53cd5e..c8539c4f5bea 100644
--- a/drivers/staging/fwserial/fwserial.c
+++ b/drivers/staging/fwserial/fwserial.c
@@ -2116,8 +2116,7 @@ static void fwserial_remove_peer(struct fwtty_peer *peer)
 	if (port)
 		fwserial_release_port(port, true);
 
-	synchronize_rcu();
-	kfree(peer);
+	kvfree_rcu(peer);
 }
 
 /**
-- 
2.30.2

