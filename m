Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE8915F41B;
	Tue,  7 May 2024 09:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074571; cv=none; b=BfMlZgSDQhalCE5b14zP/hieJvKL2vv3cNSQVIiS7n8Aouo197e/qHDnsXQBkrvc/eCrNDd9KU2hVSvvtoIgWee/Ei95OO8sQ17eALPcTfz6MlBKk7+nyV+dPMd/ImizFCk0Bxkqa+fC5a/ccd+E22EYg8Q2+i3YDdeR4cH+M/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074571; c=relaxed/simple;
	bh=ToAdu7RjzQdPvjL5csdGxaziISsWmJ7d6C2sZF1asqI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RYeAKXBgeF28zyELu6+bU3ICfrh6YGoSQ61xqz6poRgxHmxlOHLiaR+CxwdO7Bq57zJ+4eoIj3xJVczOox1Ozylsl0lWV4Bv7DZMp9LfFQ01wWqXOfRXAI2Lj4fLyr2HuTsypnaerQ2OuBgSxz6xIgmnQLyKHV89h9fU1TbTaHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ws5Ar5K9; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ws5Ar5K9"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2e2a4c20870so37456891fa.3;
        Tue, 07 May 2024 02:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715074567; x=1715679367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lWO9GAa6Vpz9dtNuoHPKqA+NV6gG2l18egBHY+/A1h4=;
        b=Ws5Ar5K9D4NCl8rOsy3W+lQApINN4vsf679fJ00RULjajSgs2wjb4UHQDQnDMV1Y7y
         /otQGYNqHTpdZJfmo1E7O8mZi0yLxPAR/+V5G+XokMfr95AtldcnEAbAuZrE32e9EHX7
         As7OBsmRcKDQ9vm+1CNLXkLeh1Ss5Zp+chaauPlpf/STf/a/JgTZ604/20ecldKd+I3I
         tIBybPzkyrmmBquYrX10l6sXxfjyrCc3dCzOLyBtZOQnNicIpX8b6gMP5eM5dKNPBKM4
         hC4OAx9v83FbCKpVUldTfhuyiZ/kXqGQqbmIc6NAPvO/5uOI1+QZH4hOelrD7pcin8iD
         eVjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715074567; x=1715679367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lWO9GAa6Vpz9dtNuoHPKqA+NV6gG2l18egBHY+/A1h4=;
        b=LGzpQiBM7arBAR8TWItQD0oR+kr2PSxwnMOzcYGQr97jGgtYPbVcr7XbkfJd5Ol8jd
         Jh7n5d3n89RIDUyLWWcb+eAGSe3xtDkb7MyMnTJcil+4zfLoq/2q1u2pLGKYG5v9vSKa
         QBl70aEF/qDUA65DulAbE+OdCmxJHL+LtzImlJCdcHYv9Kg1fFzT6/aeygIGzZijNNTh
         ykli36GIaAaWemhRHtu/9ZoG3o7uwnDPf2exLNsWOp84IfSjx2jjn/GRyHS7Ncf2ewxf
         Hl9DWjG/firdgkHEX31XsNG3ibFnhJCZkDZAKf8tbXrL0r8PIS1OCL1vAVsW7I59MpaH
         F7Nw==
X-Forwarded-Encrypted: i=1; AJvYcCUY7X8OFP8dfhaih2uTowfbsNz1cUKZmF2dM4iBNEN5jdrBrCGfnHXc468vOEflaiFe/Ovq6owSmD3yg87qvuAr2SINd+xx75Og6a6q
X-Gm-Message-State: AOJu0Yy0qmv53YFdKcOm1844So6INCaXQHFC7KE7xWnG+uvYy5KoDI2G
	ad3K5ePzOCOs6vZrC5XYRLBtt1UiKplvNabgFR9k/7b98mG97FDs
X-Google-Smtp-Source: AGHT+IHPnKvfOjFZr/dR+aaCu8enNiYVRchJi0ShOWXgYLMb0fJZQCr5XHybb87C5Hh7wnCLzYZn0g==
X-Received: by 2002:a2e:87d9:0:b0:2e1:a8db:2bca with SMTP id v25-20020a2e87d9000000b002e1a8db2bcamr7681329ljj.48.1715074566779;
        Tue, 07 May 2024 02:36:06 -0700 (PDT)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id t18-20020a2e9d12000000b002e29c50c4dcsm1335473lji.27.2024.05.07.02.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 02:36:06 -0700 (PDT)
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
	Nikita Kiryushin <kiryushin@ancud.ru>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 34/48] rcu: Fix buffer overflow in print_cpu_stall_info()
Date: Tue,  7 May 2024 11:35:16 +0200
Message-Id: <20240507093530.3043-35-urezki@gmail.com>
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

From: Nikita Kiryushin <kiryushin@ancud.ru>

The rcuc-starvation output from print_cpu_stall_info() might overflow the
buffer if there is a huge difference in jiffies difference.  The situation
might seem improbable, but computers sometimes get very confused about
time, which can result in full-sized integers, and, in this case,
buffer overflow.

Also, the unsigned jiffies difference is printed using %ld, which is
normally for signed integers.  This is intentional for debugging purposes,
but it is not obvious from the code.

This commit therefore changes sprintf() to snprintf() and adds a
clarifying comment about intention of %ld format.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 245a62982502 ("rcu: Dump rcuc kthread status for CPUs not reporting quiescent state")
Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree_stall.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 8a2edf6a1ef5..460efecd077b 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -504,7 +504,8 @@ static void print_cpu_stall_info(int cpu)
 			rcu_dynticks_in_eqs(rcu_dynticks_snap(cpu));
 	rcuc_starved = rcu_is_rcuc_kthread_starving(rdp, &j);
 	if (rcuc_starved)
-		sprintf(buf, " rcuc=%ld jiffies(starved)", j);
+		// Print signed value, as negative values indicate a probable bug.
+		snprintf(buf, sizeof(buf), " rcuc=%ld jiffies(starved)", j);
 	pr_err("\t%d-%c%c%c%c: (%lu %s) idle=%04x/%ld/%#lx softirq=%u/%u fqs=%ld%s%s\n",
 	       cpu,
 	       "O."[!!cpu_online(cpu)],
-- 
2.39.2

