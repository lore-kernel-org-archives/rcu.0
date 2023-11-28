Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htrmT2Wz"
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC55419D;
	Tue, 28 Nov 2023 00:00:40 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50aaaf6e58fso7777336e87.2;
        Tue, 28 Nov 2023 00:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701158439; x=1701763239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XhGfiMA+FxwDjc7t0nt/AcmpjpbgCOpq64Uuwhjmwcc=;
        b=htrmT2WzhWPg7YEYgl2rpQyaKIWN33ZAih/zXMGkVoQ91n4WxzTqefDewirCLxdu/U
         pB9fVtemOF/W3UYMQSiZT05DnY5J9RYlnga4ZPmbmhaV6azq4mvE6Vn6hmOWIYv3zVLV
         QfSobqiY9MM08TmnGgkwwVL3k/ezTdNg0TOio01f7GiHtACtnlu4AkZvh8IWQKPmdloY
         LwVvBtEchYnKbdZijLZod2RYmBKta17QPfqqKDeZc0xLcjyZ/ouc/LNXb02abBDi1fh2
         CoQsN6xgYTIoZ0il+7+SlOkloPU2ZADGyn/evKjIQfwr8AFU4QSwOvtjnimAOx60rS5R
         y3uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701158439; x=1701763239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XhGfiMA+FxwDjc7t0nt/AcmpjpbgCOpq64Uuwhjmwcc=;
        b=Dipc1XNKHsfAR/hrNghEilNB2AjbwYjTM9KVtqaLTQFus61IYFzWMp4ZKBSRQ67kDb
         96p346e3ZtIF+Vv6CX/pAjFBuV3wGBLmZGh2s4keaZpQh06cq7p+7jwbJsKzXUMym/N5
         G9Q1stEB5Qvsb/whdlRL0wbuh4vKBZCmONw14/daZZsxHhUgQgZAJX7sm+xYS0p7afpN
         YgiGYBlEA5qEtJ6hUEZ/hzqZqP1k/ZNg5+axihGFyTmsP7B8JD+iwOP8qbNJbmpynHKm
         SvN1bcze80pbtKM5ZJ95j/TPteKr4OztHmPj5Ad6jW4VwrP49jp+A+L8RBRQper8OxkF
         GTqQ==
X-Gm-Message-State: AOJu0Ywt3Ay4HQGPoeYzs0xPMLN8cKQa3lKaMBmBS+SLuUUm10y0skr1
	q8E6QpRiRPo7vVOLmDnbDOc7Hu7jtWs=
X-Google-Smtp-Source: AGHT+IE/LYlsTrWkg7977AH0uge/4rfAnM8l3c5uoqkgIxckVASEsPJezyjKjS17I73AR9ZDfBbhxA==
X-Received: by 2002:ac2:563b:0:b0:509:145c:6a49 with SMTP id b27-20020ac2563b000000b00509145c6a49mr8953744lff.42.1701158438666;
        Tue, 28 Nov 2023 00:00:38 -0800 (PST)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id o16-20020ac24bd0000000b004fe202a5c7csm1765501lfq.135.2023.11.28.00.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 00:00:38 -0800 (PST)
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
Subject: [PATCH v3 3/7] doc: Add rcutree.rcu_normal_wake_from_gp to kernel-parameters.txt
Date: Tue, 28 Nov 2023 09:00:29 +0100
Message-Id: <20231128080033.288050-4-urezki@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231128080033.288050-1-urezki@gmail.com>
References: <20231128080033.288050-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds rcutree.rcu_normal_wake_from_gp description
to the kernel-parameters.txt file.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0a1731a0f0ef..65bfbfb09522 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4944,6 +4944,20 @@
 			this kernel boot parameter, forcibly setting it
 			to zero.
 
+	rcutree.rcu_normal_wake_from_gp= [KNL]
+			Reduces a latency of synchronize_rcu() call. This approach
+			maintains its own track of synchronize_rcu() callers, so it
+			does not interact with regular callbacks because it does not
+			use a call_rcu[_hurry]() path. Please note, this is for a
+			normal grace period.
+
+			How to enable it:
+
+			echo 1 > /sys/module/rcutree/parameters/rcu_normal_wake_from_gp
+			or pass a boot parameter "rcutree.rcu_normal_wake_from_gp=1"
+
+			Default is 0.
+
 	rcuscale.gp_async= [KNL]
 			Measure performance of asynchronous
 			grace-period primitives such as call_rcu().
-- 
2.39.2

