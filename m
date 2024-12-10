Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8792153DC;
	Tue, 10 Dec 2024 16:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733848843; cv=none; b=UCO5zYa6IHN6nzbcHDYv6pnFny+r6ZNpg4mmqvKn7JEnbqzRysgU3Gn4bzkh1ZYMOGaqK4x2lx4mzePxS2i/UrIRKWhBnMpWfX+mJajpkJsyIj4HSGup1lVmDviaxvO3cZwpajOgqChcQsdte8T2lA+p4lBh3J2sHOCwQXOsgsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733848843; c=relaxed/simple;
	bh=96C4Ff7noTHvUfYlu51M40HOaWBfgD2burIr67S83dc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nxh1kbm44sLlkd6zsZfEJGW6SGWVhJM+4WaGizX0IXfzko0Tdma23GGp4ioXcua3lr8jO4lMEfq+SL6vXvCP8n9mek38HHfN+t03JPzwtASFq55+jPypCjqcaSaIntmtne4dyaH69ZPSouCCZbvPoOvoIv23LBYur7p7mBQpanY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QixbVDay; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QixbVDay"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-540215984f0so2069953e87.1;
        Tue, 10 Dec 2024 08:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733848840; x=1734453640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ClETbVzs2/eIlopkwOYmZeoS18KY5TfMVLeWid2GulI=;
        b=QixbVDay9+thajhGScGmLN64oUI/s1BoxkH/O+lIyz8sAn6b0uLq8xnWb/BqlPSjiM
         knyjMzHQfv0uDIySRbmj9SBwCysrnrbLHCfoxPSO3QdMJhNJUSFA/iYhI5ny6TqOFPfG
         +QPhdG74py5+/ZVwYuotYCA9+pe4YMfvGbAbNzu4MS2dIJJQn3lKT1Cizm3nKjKtJCZz
         xfe0QUb8YTQPfZPDB3hzWggoq2n+S/zs+IMfar/MIvn6jOXQzhVb/N2+0X/iNpVbhyoK
         eOKlpKIZeKWSXZ461TAxLEL8/j+etKCk3uxpFqWqlBG/O4IMNVqBD3U0HrQfyYxtcRIf
         BBfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733848840; x=1734453640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ClETbVzs2/eIlopkwOYmZeoS18KY5TfMVLeWid2GulI=;
        b=W1x2dlII2dC6KrUbgDxtygyN1leK89GwWqMyvi7SogZq30tbZxygih51L2JDJndANA
         0PKAzloeLgbMB1GbONez5m56uiMglj6jgH9qlTxKI0jyPaVjqjTes2x3wWn6no9TV08X
         S3cTPPVtBZMXg2ny2XwkXHLkGcf9kBYilQEIn1T0WCaM2BT0/thkwgeKE/KI7GGcoIUr
         3X/rkopA6KSglJZAvNsnIkFrPD30DB7zslZ/tDPNv8fYHrl994kyUuWgqyGJAEYxTZe1
         VpbykuD7l+HSeoANYTX0Wekh5r3Klr2fEH5oS69Jq4w7EilGPx766+xcVFxSZ7Mc1m5O
         2D9w==
X-Forwarded-Encrypted: i=1; AJvYcCUFcltvoMJb4ZP5wCcChQspZxo8tCjIaF4cLZTn/spxqc3MxPP0jBP0tITPON6+8eIXJPmHFy7PMG5A0gs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8Y+kxl3c4KAd+/43ZezTuyBaGUkIXgAF/B5SYqnlqwuiEkIx/
	ibJYP/7lxxdC96aYzMb8IcjlF5ju3hMJcQ7Dickg8UjP2GcGCmDq
X-Gm-Gg: ASbGnctKjSp2QAgbxbdVYhE/LArClpTLpuAh7OzmJlZvOTAFN3DasVnGwIOCpQfjLH7
	7rmv8diOli8v0KeCphZiWBYBKDiISs53iz/w5Q88XIBt3CcL0MzaN4EAaAS1n0EvEBK8yRJqq6h
	yMuOsnwHyNIFfvNWc/+Eme0601JjGbQb6oiRiWFYW0kQI6TnUx30afpS8odtKH5yxp9vEb1ykbv
	QIGuwUrKjy/olxRsVrGETa/FdNfuZrlIRrpKy6+tCt9yvP/uQ==
X-Google-Smtp-Source: AGHT+IFLmxwSZlSjwaR27QpJke6rURhJNzaMl3K1lpQik83HRlwxxz03FF+x+GNaY58FSlMOxRq9gA==
X-Received: by 2002:a05:6512:ba6:b0:540:1fec:f322 with SMTP id 2adb3069b0e04-5402410485emr1773977e87.39.1733848839554;
        Tue, 10 Dec 2024 08:40:39 -0800 (PST)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53f93377eefsm1031875e87.67.2024.12.10.08.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 08:40:38 -0800 (PST)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>
Cc: RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [RFC v1 2/5] mm/slab: Copy main data structures of kvfree_rcu()
Date: Tue, 10 Dec 2024 17:40:32 +0100
Message-Id: <20241210164035.3391747-3-urezki@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241210164035.3391747-1-urezki@gmail.com>
References: <20241210164035.3391747-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch copies main data structures of kvfree_rcu() API
from the kernel/rcu/tree.c into slab_common.c file. Later on,
it will be removed from the tree.c.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/slab_common.c | 95 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 893d32059915..a249fdb0d92e 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1338,3 +1338,98 @@ EXPORT_TRACEPOINT_SYMBOL(kmem_cache_alloc);
 EXPORT_TRACEPOINT_SYMBOL(kfree);
 EXPORT_TRACEPOINT_SYMBOL(kmem_cache_free);
 
+/* Maximum number of jiffies to wait before draining a batch. */
+#define KFREE_DRAIN_JIFFIES (5 * HZ)
+#define KFREE_N_BATCHES 2
+#define FREE_N_CHANNELS 2
+
+/**
+ * struct kvfree_rcu_bulk_data - single block to store kvfree_rcu() pointers
+ * @list: List node. All blocks are linked between each other
+ * @gp_snap: Snapshot of RCU state for objects placed to this bulk
+ * @nr_records: Number of active pointers in the array
+ * @records: Array of the kvfree_rcu() pointers
+ */
+struct kvfree_rcu_bulk_data {
+	struct list_head list;
+	struct rcu_gp_oldstate gp_snap;
+	unsigned long nr_records;
+	void *records[] __counted_by(nr_records);
+};
+
+/*
+ * This macro defines how many entries the "records" array
+ * will contain. It is based on the fact that the size of
+ * kvfree_rcu_bulk_data structure becomes exactly one page.
+ */
+#define KVFREE_BULK_MAX_ENTR \
+	((PAGE_SIZE - sizeof(struct kvfree_rcu_bulk_data)) / sizeof(void *))
+
+/**
+ * struct kfree_rcu_cpu_work - single batch of kfree_rcu() requests
+ * @rcu_work: Let queue_rcu_work() invoke workqueue handler after grace period
+ * @head_free: List of kfree_rcu() objects waiting for a grace period
+ * @head_free_gp_snap: Grace-period snapshot to check for attempted premature frees.
+ * @bulk_head_free: Bulk-List of kvfree_rcu() objects waiting for a grace period
+ * @krcp: Pointer to @kfree_rcu_cpu structure
+ */
+
+struct kfree_rcu_cpu_work {
+	struct rcu_work rcu_work;
+	struct rcu_head *head_free;
+	struct rcu_gp_oldstate head_free_gp_snap;
+	struct list_head bulk_head_free[FREE_N_CHANNELS];
+	struct kfree_rcu_cpu *krcp;
+};
+
+/**
+ * struct kfree_rcu_cpu - batch up kfree_rcu() requests for RCU grace period
+ * @head: List of kfree_rcu() objects not yet waiting for a grace period
+ * @head_gp_snap: Snapshot of RCU state for objects placed to "@head"
+ * @bulk_head: Bulk-List of kvfree_rcu() objects not yet waiting for a grace period
+ * @krw_arr: Array of batches of kfree_rcu() objects waiting for a grace period
+ * @lock: Synchronize access to this structure
+ * @monitor_work: Promote @head to @head_free after KFREE_DRAIN_JIFFIES
+ * @initialized: The @rcu_work fields have been initialized
+ * @head_count: Number of objects in rcu_head singular list
+ * @bulk_count: Number of objects in bulk-list
+ * @bkvcache:
+ *	A simple cache list that contains objects for reuse purpose.
+ *	In order to save some per-cpu space the list is singular.
+ *	Even though it is lockless an access has to be protected by the
+ *	per-cpu lock.
+ * @page_cache_work: A work to refill the cache when it is empty
+ * @backoff_page_cache_fill: Delay cache refills
+ * @work_in_progress: Indicates that page_cache_work is running
+ * @hrtimer: A hrtimer for scheduling a page_cache_work
+ * @nr_bkv_objs: number of allocated objects at @bkvcache.
+ *
+ * This is a per-CPU structure.  The reason that it is not included in
+ * the rcu_data structure is to permit this code to be extracted from
+ * the RCU files.  Such extraction could allow further optimization of
+ * the interactions with the slab allocators.
+ */
+struct kfree_rcu_cpu {
+	// Objects queued on a linked list
+	// through their rcu_head structures.
+	struct rcu_head *head;
+	unsigned long head_gp_snap;
+	atomic_t head_count;
+
+	// Objects queued on a bulk-list.
+	struct list_head bulk_head[FREE_N_CHANNELS];
+	atomic_t bulk_count[FREE_N_CHANNELS];
+
+	struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
+	raw_spinlock_t lock;
+	struct delayed_work monitor_work;
+	bool initialized;
+
+	struct delayed_work page_cache_work;
+	atomic_t backoff_page_cache_fill;
+	atomic_t work_in_progress;
+	struct hrtimer hrtimer;
+
+	struct llist_head bkvcache;
+	int nr_bkv_objs;
+};
-- 
2.39.5

