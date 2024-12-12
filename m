Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF38223E61;
	Thu, 12 Dec 2024 18:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026540; cv=none; b=jv8dHn3XklqY24KJBvnxMc8dJMBypYNNmOEoEjM4XFZdcbta4ZiZ5AgMPpoOYm7TN0WU9DXgKSBXr1OuzCw5WM1veryZr8RcRuc926wLUTo37mZmwPyKhetBrOdkLBeIkEx6lQE1bpUAHsICLgXPng0s8/8VcJcl3TIIRjW13ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026540; c=relaxed/simple;
	bh=XWV97xP/r4UDSQKDouWkQk3sT3ICD6AkRujtrirfj0g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j+rk9c6Iv4K9Z3gtgXjxj8Ao3kqDwbWj4NfRHu8Xdv/P3SkdG3crz9xkxqALyDbTH6vl9l/dEi0RIRhnQaDYmby79V6br1mSl+jwqmEt+Jf1uem7sY8chf5uXDbhNrB1pY8hwElPUb7amjSTb9Q7H15p3WLjJqCN1S/FqUv68uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MaZq5cEy; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MaZq5cEy"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53e28cf55cdso782250e87.3;
        Thu, 12 Dec 2024 10:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734026536; x=1734631336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hv8QfUHYhhVaP7flYxocwH+u3wceiEtGo25bo7k3AuU=;
        b=MaZq5cEyRdXeIeUevgkjLoPuKuz3kbGcqDTPmSlVMTqsUnoZX3QfD+HRRzSqVHiBmj
         K64ujbP2vNI8NCwisElu6mCAtBQ7/KBoY80AiBqHmXZAeXLaPbMRfPRnBPSVVQ9fIMaX
         2is3XJZsN8vTiHhWKooRYxvt68cVzB0JxvHmgWJfWZGuMsPgbt8Kep3JZ4amTwYb7hL9
         r3BsqFD7yXVug+3Tvy0wVYdpx3HUHV6wU8jf1H8MSojz+uk6U0OEA6X4jY7562AnpyUA
         DNA9/N1Pd3Gm0WCGjIgC20N2AigYPDqtR9wyavgWj8roUXTNvawEl/DnG6LDx8X/Jd60
         sKvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734026536; x=1734631336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hv8QfUHYhhVaP7flYxocwH+u3wceiEtGo25bo7k3AuU=;
        b=ehDfvcBIJLWKamCw6YboJalWYKZjcSEvR/2U6hQOxNhEBX24oMUutgHVIaxvaCEHBk
         H4hOTzHLiORGs4SQKcTCID4pKPcS421OmlF8QXW+mY/eeaw7nhvDHsopsOlu3n/JVVsp
         MExzxtQV41L6aKsLrWTt64sbCUt+3Zxgi7fPMWRrlnU7nwvrRlxwHXR6Yh6sTxr+WqfY
         ZyYk9SIN/5xgwGjegD6yDn0U9h0S13qWpuEWAWrdviBsUEP1gLqiOYiMmxiDbXMK8svB
         dbe9I1PWSCDgxMeFXScnL5mYehSrJyBiO6Q0ZRIxZrrdiCCfpoUz8hf0umVeXFFRAl1i
         zSWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfXC2omZ3r5f84pYaH5wHa9683P1hZYjaUfQ+97b8dVLSKmbH8hTu1bCUEK0jDWpC8lgunMZuCTTv61m8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnvRENzrvmKg+qDR1MqxBDqHcvNjDNEngh3DLK+iGxZg8PI8kP
	Tr6VoJJO+22yDtDpjk43dvfS+OkGoeLZPW5MEKt9WGoK90cbXFzV
X-Gm-Gg: ASbGncuYEBbDoiuZJrKCT82eC+x0XDESw0mnuWU8w3NeZy3INniN8BS6swoMlct4YM6
	2CbabYkyFjs5onVqGGomAyBEgIT1EHHXlxHa6OCuhHyQr+mEG2N3GNHvkQcAlXpiZKdfMLnwbE2
	cPD90JgK4+tDuMRQpjzG68lAfSXge6aKftm6RzcJZON0G3rnu05bIh4iLWY2ea/cu/NfPSMRUFG
	/nReIEm2JpyhKtrOmlj/UZfr5WYMhS0wVGl2hIV4od5f7sbGQRf
X-Google-Smtp-Source: AGHT+IEBa7W43d+GZY0D/NIRGJ6K2KBC2g84iLkFM9fwOtfd8BrPro/IcWJVgAX73Jiv6rWzaqnyWw==
X-Received: by 2002:a05:6512:690:b0:540:3561:969d with SMTP id 2adb3069b0e04-540356196d3mr8441e87.49.1734026534397;
        Thu, 12 Dec 2024 10:02:14 -0800 (PST)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e39375d36sm1940645e87.7.2024.12.12.10.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 10:02:13 -0800 (PST)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>
Cc: RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH v2 3/5] rcu/kvfree: Adjust names passed into trace functions
Date: Thu, 12 Dec 2024 19:02:06 +0100
Message-Id: <20241212180208.274813-4-urezki@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241212180208.274813-1-urezki@gmail.com>
References: <20241212180208.274813-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently trace functions are supplied with "rcu_state.name"
member which is located in the structure. The problem is that
the "rcu_state" structure variable is local and can not be
accessed from another place.

To address this, this preparation patch passes "slab" string
as a first argument.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index b3853ae6e869..6ab21655c248 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3379,14 +3379,14 @@ kvfree_rcu_bulk(struct kfree_rcu_cpu *krcp,
 		rcu_lock_acquire(&rcu_callback_map);
 		if (idx == 0) { // kmalloc() / kfree().
 			trace_rcu_invoke_kfree_bulk_callback(
-				rcu_state.name, bnode->nr_records,
+				"slab", bnode->nr_records,
 				bnode->records);
 
 			kfree_bulk(bnode->nr_records, bnode->records);
 		} else { // vmalloc() / vfree().
 			for (i = 0; i < bnode->nr_records; i++) {
 				trace_rcu_invoke_kvfree_callback(
-					rcu_state.name, bnode->records[i], 0);
+					"slab", bnode->records[i], 0);
 
 				vfree(bnode->records[i]);
 			}
@@ -3417,7 +3417,7 @@ kvfree_rcu_list(struct rcu_head *head)
 		next = head->next;
 		debug_rcu_head_unqueue((struct rcu_head *)ptr);
 		rcu_lock_acquire(&rcu_callback_map);
-		trace_rcu_invoke_kvfree_callback(rcu_state.name, head, offset);
+		trace_rcu_invoke_kvfree_callback("slab", head, offset);
 
 		if (!WARN_ON_ONCE(!__is_kvfree_rcu_offset(offset)))
 			kvfree(ptr);
-- 
2.39.5

