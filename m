Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47836568A;
	Fri,  8 Mar 2024 17:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709919256; cv=none; b=u0AhrShlM2NiEPOIy/oIyK+qOupQA+QMj6QHAXWppSqFbQ95j9DK2zuHUkM/QSNOl/mnMvR4Zi1jdL0t4y609GzklV13fz+kJJsuVVgvUZJ1VghZahUW6BSV/UKQneIqT5Yve1//4Ef+M7YZ1ifE/xxZZu3JB/eNmF+pmDN+lQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709919256; c=relaxed/simple;
	bh=+sM30cOyHqXSmmhxaV2sjUAEf1nC4m+PeirwUjejQqo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VZHnoy9lqdM+bzzL/MGRRDj9LahXpmm6SFBDu71GHbjP6cZ+1tABTlcS54RUerUpRqMyNYMAZDU9GgpOACy5T6Ci3G5xHJtPF2DurP5i5gmUDf/s+PYo0Ns8gTxPCi6vTwqRL/1B9SZ5EtzPoEepP4hT2CtOwMyhPMagmtISE8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DBhrncvN; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBhrncvN"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5131c48055cso2668960e87.1;
        Fri, 08 Mar 2024 09:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709919253; x=1710524053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jOpDJiuEMajeibzl8V5uZUX1gqeJEBwIDoQaXh828aE=;
        b=DBhrncvNjUivOKrZOm7f9SmW6War2ElLSRGpgp3r/SZS/59sI1gcRx97Atw2HQXWPV
         iiDrOHRHI7ss+P7PX+JMMVBbK0tG3t2WWzBv5N/x5nuJPAxp5eC/9wifvGtnaC8MmoKl
         MAaPTFtd2akeiu05ZkPIBlqObDTz9XSTVDgWc+Q+DeCfYIfzbJS/cIsaDvTLSfIa+CR/
         yrqimrcd6H3nbQezQn9Ac4mBvZ9tLiat/lccnLrbPfeQwnP1PZqyiUqjJZEMUvnbUt7I
         oGqVhDz8jC8Cewig4cG5exq12H24Fz2Bg71oJtn0CaGr2Tea6LVrQSotfTgjzqtebCJC
         suZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709919253; x=1710524053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jOpDJiuEMajeibzl8V5uZUX1gqeJEBwIDoQaXh828aE=;
        b=NxKWBffEMRX+ZFcyjG86N/GpzdhdUUNrilMpQ5LR2Y7ImceWzDKA2fTQiriwP+UX2g
         gMxddTqDNUn+LrDgGklTpNBavz77ikKMtdEz7gALuKoBOjAeDwvNZYNcBWZf9t/z2upD
         rUSq9EQvO6FSgpXmPRTm/gWlkemdNWgoUkOuG5RyZMMMYmqnF0Zv1f/5j46l6Qpxj91X
         P61hzRZTmMhbxzhITp4mamEkHqdxVRVsDLGIKFmR2jtOp/yjEDQR+WOsKdLY2iuhOeLK
         KCVYUFp4lqCBHOOoU58CzDlkppVvGeAG1plRuDpGtS3wAAEJqzdekHrMw9smVa5rp8AY
         RCUw==
X-Forwarded-Encrypted: i=1; AJvYcCU+a96gV7WLoJjfLM1Joh5xwdLZwzVAwu1orz0RRGHRoggWfMGmW0sj3E7mFJve24xz+ahtI1Ex3T9bV9q7T5yNKhJQQM+gal7wl/db
X-Gm-Message-State: AOJu0YweDyGH3ERWGx/Q2vyUqenn5XsBo1UBbYftMCbyy/mx8CYDUuZE
	t2rHHCbxKBxRIkN323r3DxgsbHfiFVyQ4FLTGbD1wIH1C66OEs3n
X-Google-Smtp-Source: AGHT+IH+PQeVlCzofdLfMc8Gj/FLZaAGqr6IVOI8KbixI6Z9BFsnX/bMxCChXoNFbGLsem/FB+rV/g==
X-Received: by 2002:ac2:4289:0:b0:513:1385:c943 with SMTP id m9-20020ac24289000000b005131385c943mr3475035lfh.40.1709919253367;
        Fri, 08 Mar 2024 09:34:13 -0800 (PST)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id a23-20020a195f57000000b0051333e2f55dsm3150504lfj.159.2024.03.08.09.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 09:34:13 -0800 (PST)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>
Cc: RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH v6 1/6] rcu: Add data structures for synchronize_rcu()
Date: Fri,  8 Mar 2024 18:34:04 +0100
Message-Id: <20240308173409.335345-2-urezki@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240308173409.335345-1-urezki@gmail.com>
References: <20240308173409.335345-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The synchronize_rcu() call is going to be reworked, thus
this patch adds dedicated fields into the rcu_state structure.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index df48160b3136..b942b9437438 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -315,6 +315,13 @@ do {									\
 	__set_current_state(TASK_RUNNING);				\
 } while (0)
 
+#define SR_NORMAL_GP_WAIT_HEAD_MAX 5
+
+struct sr_wait_node {
+	atomic_t inuse;
+	struct llist_node node;
+};
+
 /*
  * RCU global state, including node hierarchy.  This hierarchy is
  * represented in "heap" form in a dense array.  The root (first level)
@@ -400,6 +407,13 @@ struct rcu_state {
 						/* Synchronize offline with */
 						/*  GP pre-initialization. */
 	int nocb_is_setup;			/* nocb is setup from boot */
+
+	/* synchronize_rcu() part. */
+	struct llist_head srs_next;	/* request a GP users. */
+	struct llist_node *srs_wait_tail; /* wait for GP users. */
+	struct llist_node *srs_done_tail; /* ready for GP users. */
+	struct sr_wait_node srs_wait_nodes[SR_NORMAL_GP_WAIT_HEAD_MAX];
+	struct work_struct srs_cleanup_work;
 };
 
 /* Values for rcu_state structure's gp_flags field. */
-- 
2.39.2

