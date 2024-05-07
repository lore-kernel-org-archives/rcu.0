Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B164915F3FD;
	Tue,  7 May 2024 09:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074569; cv=none; b=At3QjI1248GyFl1xrAifFmaVNDTXMrgtspGgJ+0FcwqsDcyjCOgLg9h3pAdHB/UshFITtFQTFv89AfYl6XX7vDdR9ffjAasUXTHlxPUFIBItUXpBGT39Y9gjiW2leoOtLMP6EOKYiwjnOja5DD+BHQnOX0ZESam6lVzDtgGy1TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074569; c=relaxed/simple;
	bh=rtlgupwLn0mEHf5kQVI1HauKwRCtBdwM7YKs0MzkqOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jvPTE543jchiN9IyJtjL9mFckrhL3iqNd8tEEZ/2TDx0Aj8xTxKQZoC+vKbFed/ukOb578e00dezWdtIHmd6eRULYaw+wzyvxz7PA9HjkgQ4GYRoQOB8Q6+prNt1RP7G7RWukZ1sRu5akTQAiYmILUYDlK6kWVNL13ATdROLgK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OMOKybu/; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMOKybu/"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2e2c70f0c97so36450981fa.0;
        Tue, 07 May 2024 02:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715074564; x=1715679364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u129STYD4noSkSCV7bqtBz9/OCTztdlN/hG4nYi33QI=;
        b=OMOKybu/RRCKXDYNd9UavdQeBxrOeAqRcSxrBELL0nkkxRjU8zKyNtLiRrVuwI5o+U
         oE3cihaSLHBooFe/TGjFPZfq8vSnl/dwClvxlfc8WSltJZ6augf/LsMljUxyO/hUC9gR
         cHsn6vA8DxtAQe57369x7h0xTUUjM9Y5tZzFMiawrOPF61DUiNXa85j3WVyjNJNnEF46
         owWdtHolqUNQ4524Ocd48+8zW5P3ln5H3sxqk9VOEy+LBsf7n5yJnBUbxpLoDvnevuuQ
         iFy2BsSTeBLsSvVnOZb9jNzCchQsc5+Tp7YNAnitWFl60j9CPg3/SUNF7PZVZZ6kZzsL
         5t6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715074564; x=1715679364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u129STYD4noSkSCV7bqtBz9/OCTztdlN/hG4nYi33QI=;
        b=aEjJXLBjm6JgplRX2vvSo19IqwqwB/X5n2SgCo2dQdQWeGHLbAvjfMy1DGxXmazXek
         U6ui65FgUEEUwo9ZB3PePeM9SWKNEU3nFrZE4dpNSnG/No0MovUdZyXenn4DdaOJt7cM
         g7NNcmIHilKAxSDT3sJ/ZpGCs82L8CXeWOV8e7DtNV2U118DvnYPYd7O44IbDjAMwkEL
         qdFVcSKiAuHyR8oVEvia9CUFRZWlaiRFCrbUFTrasTWaMzB8RsW0bMR9rs9sIzba0T32
         PNYCL8Bj7URhDby1WZsrgqFu4DsDff9hKUOT97ustvYDadWVTBy7JV1IUpiabske8jkN
         HWLA==
X-Forwarded-Encrypted: i=1; AJvYcCVah6SxtlacwUXrM59kXSYpT25M86rr+v9q58TdSHLZXP2ZyMqRQpQ4RnVmQ1u4w1w+B2lhWvzuS6SuRroAefSt3Dw3mULWTjbX2WRV
X-Gm-Message-State: AOJu0YwygtZtVKYkXmEv9uz0xyoVlWE7GsPwg5DrT0T9E+/VfSHTG4Go
	uR8/1G7shotw5dpVph+8xZMPj+lX1M/0gc9BYM7nK71NIIKi5WMU
X-Google-Smtp-Source: AGHT+IEpA2noZYzq8aC+0HCkFA+QhYdvlE4pW2LiUMUeMOTxNI385y3P3dy0MafU/I9r8SZ8wVetJg==
X-Received: by 2002:a2e:610a:0:b0:2e3:1991:ec1b with SMTP id v10-20020a2e610a000000b002e31991ec1bmr4030953ljb.4.1715074563454;
        Tue, 07 May 2024 02:36:03 -0700 (PDT)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id t18-20020a2e9d12000000b002e29c50c4dcsm1335473lji.27.2024.05.07.02.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 02:36:03 -0700 (PDT)
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
	Frederic Weisbecker <frederic@kernel.org>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: [PATCH 31/48] rcu-tasks: Fix the comments for tasks_rcu_exit_srcu_stall_timer
Date: Tue,  7 May 2024 11:35:13 +0200
Message-Id: <20240507093530.3043-32-urezki@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240507093530.3043-1-urezki@gmail.com>
References: <20240507093530.3043-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zqiang <qiang.zhang1211@gmail.com>

The synchronize_srcu() has been removed by commit("rcu-tasks: Eliminate
deadlocks involving do_exit() and RCU tasks") in rcu_tasks_postscan.
This commit therefore fixes the tasks_rcu_exit_srcu_stall_timer comment.

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tasks.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 78d74c81cc24..d5319bbe8c98 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -150,7 +150,7 @@ static struct rcu_tasks rt_name =							\
 
 #ifdef CONFIG_TASKS_RCU
 
-/* Report delay in synchronize_srcu() completion in rcu_tasks_postscan(). */
+/* Report delay of scan exiting tasklist in rcu_tasks_postscan(). */
 static void tasks_rcu_exit_srcu_stall(struct timer_list *unused);
 static DEFINE_TIMER(tasks_rcu_exit_srcu_stall_timer, tasks_rcu_exit_srcu_stall);
 #endif
-- 
2.39.2

