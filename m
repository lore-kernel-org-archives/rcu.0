Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F62D2309B8;
	Tue, 10 Dec 2024 16:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733848845; cv=none; b=R76thtI85oqWYcf6aztUABOVETJ8BW9GZFseIpSWfxdFqcF41Tz6qZFhg14FEXPfIwUbgdKYoM6UOXN4/BtkIBSgXWxsN/MZDBQ19ujBVF4qZIKvi8Iy2Qrlsval9sPpi9NncTsgDRwlmIqjORSp80e6KCzXE2y1lhd9zzISxFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733848845; c=relaxed/simple;
	bh=atxL5PqkJtOAvQd9mjOnjPLCndaPfawFysuK+qiokr0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WNfTqD1r7h7Wdu/ILAijponOdNGRETAYHKrLBkyKYlOo7dbv7Y7+nYbFs7Ujzogd4pAt6RcAAhyUNo0o7hdJng7JF5/A9H2JhGpIVE4p/OLxCclx1DKZjpr7Y7rYwNHqdwSXEGTj7jxz2YItUTXQSlFHDpxk5BO6PdWjHg3ulgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQOPZOCv; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQOPZOCv"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53f757134cdso3215054e87.2;
        Tue, 10 Dec 2024 08:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733848842; x=1734453642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8psq5tPidMqLngz98gskDzgVmEZF8iPxbnPcrOFnt1Y=;
        b=NQOPZOCveGQHYsnv4bxgUrUe3upDxo2dO7ungE1+EQGTaNgMPWJ2X0ttPNQ1R+V2T4
         PAc/d/YVuGebJxx471FBWlsM7FHKkymd+DACbxNSqYKi5i+/oyE0CydcoAkPgZxGJoqA
         GyTyjWiyxiI0S7f2wsBQQUfw5Lhm9P3iEQM7z7STrk51/MpMgH0HmGu03KIvlmEfTsMZ
         RXFIS/RxR+E0CAWS4lFGoLojn/KtXIY5hMWh84kzIEGi7fzrBP5Inn3VHiAwNW7PM+mR
         vZHAkhmobiu7g9BjRweRhBTd0zu2ztCCpN1/Nbrk2EuTb9yUAO+ukHCetcUATLzRMHM5
         exvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733848842; x=1734453642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8psq5tPidMqLngz98gskDzgVmEZF8iPxbnPcrOFnt1Y=;
        b=p/4G8cXc89RPKmeZPcFP4EkdfqjOY1ifkMLEoq3D9iI2USeU9ooF/hdtL+faJ6Tp04
         Xo71x0mWNXfHx0VSoUmxdBSB75Q133020lcINpnEDNN9YzuZovsEmW859/0Q/FQYQkfP
         WMRLaoBPuZykQhfmTKKkCvuGIaZ6ficNqJuTh7NLIWu+hx8YxLaJNNVY4J5D2llpU8vN
         FFCEPqEsalMrTLDKDg4olBTNCEWsH87KeSgfnbrPPf3s30fD12ltdriijre9GRG4Du+/
         huapOILwsXQi6ft7B4qWt/CMsECIqZSg43SeYq9dfJncbdkUGo5DNLI0dvxMCQjl9ZOY
         4vHA==
X-Forwarded-Encrypted: i=1; AJvYcCUftiVhAeCB1BueQIVw4zCDpWaqBUWGbKo0fj8iWhFxlkgZwP8u8FTdtokkjv8k1iXPY46lEr0IBAxFNak=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzto39REHWnxFb2nBWW/DX68azOksSTnJZTymMWn03rG8737QK+
	/zOXQ2c7IU9gv6PhfTY5gAVuKXOSBow/cErGutEApqHAN63rUQt7
X-Gm-Gg: ASbGncuRt5g0N88SmBtE1PfArx/s/3XU2Ktf8lZa2sbjmdX1SRCpifSMK8aYqwgHFp+
	aiiCQcbh1KCn5Xoh//a9vy6MLqDCwLcjchYPsfSoQlU4z7biEShTTqlvWKmh6d/PqdN4bYV3IHj
	m0Zbk1HnJH/NeNLZxuPFoIOgVOsxIhnfk37zXeRNNkWXUh6q3Nss3iKXqndO+qcElwNuLlUb3Mz
	GUNaZ7nZgcTwsEIvkTk3L/xEborK3Z+0anmnOybZY3exi3s4A==
X-Google-Smtp-Source: AGHT+IH7sMXWy8vZyr5EGz+tyNTQnk0FxUAmt/2tf7nxEsgjM8bPz/qNg9Wj1lm+mcn0TAZSNwIVkg==
X-Received: by 2002:a05:6512:2245:b0:53e:389d:8cdd with SMTP id 2adb3069b0e04-53e389d8dfdmr5755357e87.34.1733848841502;
        Tue, 10 Dec 2024 08:40:41 -0800 (PST)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53f93377eefsm1031875e87.67.2024.12.10.08.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 08:40:40 -0800 (PST)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>
Cc: RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [RFC v1 4/5] mm/slab: Copy a function of kvfree_rcu() initialization
Date: Tue, 10 Dec 2024 17:40:34 +0100
Message-Id: <20241210164035.3391747-5-urezki@gmail.com>
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

As a final step an initialization of kvfree_rcu() functionality is
copied into slab_common.c from the tree.c file as well as shrinker
related code.

The function is temporary marked as "__maybe_unused" to eliminate
a compiler warnings.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/slab_common.c | 91 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index e7e1d5b5f31b..cffc96bd279a 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1940,3 +1940,94 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
 
 	return true;
 }
+
+static unsigned long
+kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
+{
+	int cpu;
+	unsigned long count = 0;
+
+	/* Snapshot count of all CPUs */
+	for_each_possible_cpu(cpu) {
+		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
+
+		count += krc_count(krcp);
+		count += READ_ONCE(krcp->nr_bkv_objs);
+		atomic_set(&krcp->backoff_page_cache_fill, 1);
+	}
+
+	return count == 0 ? SHRINK_EMPTY : count;
+}
+
+static unsigned long
+kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
+{
+	int cpu, freed = 0;
+
+	for_each_possible_cpu(cpu) {
+		int count;
+		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
+
+		count = krc_count(krcp);
+		count += drain_page_cache(krcp);
+		kfree_rcu_monitor(&krcp->monitor_work.work);
+
+		sc->nr_to_scan -= count;
+		freed += count;
+
+		if (sc->nr_to_scan <= 0)
+			break;
+	}
+
+	return freed == 0 ? SHRINK_STOP : freed;
+}
+
+static void __init __maybe_unused
+kfree_rcu_batch_init(void)
+{
+	int cpu;
+	int i, j;
+	struct shrinker *kfree_rcu_shrinker;
+
+	/* Clamp it to [0:100] seconds interval. */
+	if (rcu_delay_page_cache_fill_msec < 0 ||
+		rcu_delay_page_cache_fill_msec > 100 * MSEC_PER_SEC) {
+
+		rcu_delay_page_cache_fill_msec =
+			clamp(rcu_delay_page_cache_fill_msec, 0,
+				(int) (100 * MSEC_PER_SEC));
+
+		pr_info("Adjusting rcutree.rcu_delay_page_cache_fill_msec to %d ms.\n",
+			rcu_delay_page_cache_fill_msec);
+	}
+
+	for_each_possible_cpu(cpu) {
+		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
+
+		for (i = 0; i < KFREE_N_BATCHES; i++) {
+			INIT_RCU_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
+			krcp->krw_arr[i].krcp = krcp;
+
+			for (j = 0; j < FREE_N_CHANNELS; j++)
+				INIT_LIST_HEAD(&krcp->krw_arr[i].bulk_head_free[j]);
+		}
+
+		for (i = 0; i < FREE_N_CHANNELS; i++)
+			INIT_LIST_HEAD(&krcp->bulk_head[i]);
+
+		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
+		INIT_DELAYED_WORK(&krcp->page_cache_work, fill_page_cache_func);
+		krcp->initialized = true;
+	}
+
+	kfree_rcu_shrinker = shrinker_alloc(0, "rcu-slab-kfree");
+	if (!kfree_rcu_shrinker) {
+		pr_err("Failed to allocate kfree_rcu() shrinker!\n");
+		return;
+	}
+
+	kfree_rcu_shrinker->count_objects = kfree_rcu_shrink_count;
+	kfree_rcu_shrinker->scan_objects = kfree_rcu_shrink_scan;
+
+	shrinker_register(kfree_rcu_shrinker);
+}
-- 
2.39.5

