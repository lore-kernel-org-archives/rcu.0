Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCA9243369;
	Mon, 24 Feb 2025 13:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740404228; cv=none; b=bfrCEseliYz28fsPKI/X1miV+fhaoJC12OT4VGzgPlDhWLdrViKOz97ajH8Tmo9q2FWPXUO4JLlmCK5viQkIbfH8OQP3lFLZE+qHrI4sKW7TCNrxHOXdS91HPYYLkMbsRM1ucq3qny7dK7KEFhEqKGePyz6M4bRDnZuwgoPNg/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740404228; c=relaxed/simple;
	bh=pkWTCsEa6IS0VHokuR+HUR9w20hV7VXpFtsdVk2ZZGM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tvlA1UzcFT+nFuLuTOw+xkPqfuxco1yUTCqoNNmqg31PJcjLFGAzJZiM+9yp9AygoyBq/O7h5TEhsSEWyn5w3YJUW4XfrdxpsBCp8l0+yfv2PPyk00daNizf7dvvmeMX5xFYB+1Jc6nS8aj3wFQTod/3gyIF/JplBivgfyMXF1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ar7Zk7hU; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ar7Zk7hU"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5484fa1401cso253023e87.1;
        Mon, 24 Feb 2025 05:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740404224; x=1741009024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/eXqFdLeZVXSPcLMt09mytyCkKizYEWoEdvJ/UL21oQ=;
        b=Ar7Zk7hUGXlKBxQ3mK5/tBXxB1oNeKFfpbJdW4Tg4OUTNyUly6uDKjzOtzc1afRafZ
         gH2HfHXnbgr7MMPPLQHJ8QzwamRUM8vT0oIAC2QmXghJcelwhKh03RVk86Rpvpth2aLF
         yjofy1wBl5iidijsTd+ssUTJEKlKx/MfEpekiWnW91Hh3k0aTuoso5qFPiFXH1XifLtU
         D+S2A82ZAhb3sXcGns8klc1Fjx0o5NtORXFEaTuAvVGB/A4uyyrZVdwYmUKl2CCy8OLV
         eg6xevzKUEchVlTRtokgl5dPg7GABdAx5tkUopMDzD70hqRgegIO+6I/8fcLLun9q/jN
         4mQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740404224; x=1741009024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/eXqFdLeZVXSPcLMt09mytyCkKizYEWoEdvJ/UL21oQ=;
        b=xRILiaT68aqTnAviqcLzNnjRMB9rn/0Q3sbtLnKUT9y5BVQCLUzFKm3YE4IBWhlTtj
         qfl7AEQv/2WqmqfvIPtckguPn+zlIm9wSbvOT7zzhtuQCaYP+mEX/sHBr1NQvSyHUHmI
         lqXtkQ4oNLpqosZHzmWbjNu1JrlI5qdr4gZdIq7wN7/dNjRQnY1KzjzsGhkazsVZsfG7
         FEvNGLokSA+45+Y6CGhpGDU8socOdkG7VIXZs6pJM3BrsN5s3384POP6l+/B93H0JZIR
         SEAb0S5Ivx8dKoS1hkcPeup1fWp3cQwhT33+7vNhqIcIL5XAFlvUMwKj1AC5A8OZgQkd
         hDqA==
X-Forwarded-Encrypted: i=1; AJvYcCUnwTHXd+WDbpDfEtlGvkDVDp8mc1FpD3axNSnwlmLsuKplu7fI9sXsIBbUoQCNalmwkZ86vH8H7hcirmw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9OesregyCr0HPXDvQkshFjCG2kp/DyzAhEhE8VF14jgG1pkkn
	wihveBXb8uW4TNo/nfSJ5tLBs0G57tvKfoWFsaYXRpL1hx/kOzsmJjyKb6Ee
X-Gm-Gg: ASbGncvUJb+n0pryUlPGHOhQLtx8bIPlgVtoULlwJYt9PHJknXVgD1nUjzYcoXJQuZ2
	6k+aUJO33IBXQYq7CCFj9P87H5l96lQsFVw+aSIpyjFIBqfa3ZWtlbluaqZUiNDO2Bc48yYP/h1
	OBdLrZyEGFmS/smJGfVjZw6ITIHnBqVK4gb3oeeMAL5JlaQpKbaE690vci48lptQcnAPX0yxD+g
	twCHVQuz/pvJsBTb7CwKlqKCl8j73hQS7ID/wxHhmYqGrNClp6RgnriaVbpC4/GJttTRZaxiXFA
	KnhIMkP+yirarccIYixq6w==
X-Google-Smtp-Source: AGHT+IEMNu2VKNIuFdLI6GuahDFVwEebQB5DscNSdB27lRmLJ/IUbTndD683WMxhKdu++b3WWV9Jhw==
X-Received: by 2002:a05:6512:108f:b0:545:27af:f2e4 with SMTP id 2adb3069b0e04-54838ee8c9fmr5685320e87.18.1740404224221;
        Mon, 24 Feb 2025 05:37:04 -0800 (PST)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5461eb04602sm2424799e87.68.2025.02.24.05.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 05:37:03 -0800 (PST)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>
Cc: RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH v2 3/3] rcu: Use _full() API to debug synchronize_rcu()
Date: Mon, 24 Feb 2025 14:36:59 +0100
Message-Id: <20250224133659.879074-3-urezki@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224133659.879074-1-urezki@gmail.com>
References: <20250224133659.879074-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch for using of get_state_synchronize_rcu_full() and
poll_state_synchronize_rcu_full() pair for debug a normal
synchronize_rcu() call.

Just using "not" full APIs to identify if a grace period
is passed or not might lead to a false kernel splat.

Link: https://lore.kernel.org/lkml/Z5ikQeVmVdsWQrdD@pc636/T/
Fixes: 988f569ae041 ("rcu: Reduce synchronize_rcu() latency")
Reported-by: cheung wall <zzqq0103.hey@gmail.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/linux/rcupdate_wait.h | 4 ++++
 kernel/rcu/tree.c             | 8 +++-----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/linux/rcupdate_wait.h b/include/linux/rcupdate_wait.h
index f9bed3d3f78d..a16fc2a9a7d7 100644
--- a/include/linux/rcupdate_wait.h
+++ b/include/linux/rcupdate_wait.h
@@ -16,6 +16,10 @@
 struct rcu_synchronize {
 	struct rcu_head head;
 	struct completion completion;
+#ifdef CONFIG_PROVE_RCU
+	/* This is for testing. */
+	struct rcu_gp_oldstate oldstate;
+#endif
 };
 void wakeme_after_rcu(struct rcu_head *head);
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8625f616c65a..48384fa2eaeb 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1632,12 +1632,10 @@ static void rcu_sr_normal_complete(struct llist_node *node)
 {
 	struct rcu_synchronize *rs = container_of(
 		(struct rcu_head *) node, struct rcu_synchronize, head);
-	unsigned long oldstate = (unsigned long) rs->head.func;
 
 	WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) &&
-		!poll_state_synchronize_rcu(oldstate),
-		"A full grace period is not passed yet: %lu",
-		rcu_seq_diff(get_state_synchronize_rcu(), oldstate));
+		!poll_state_synchronize_rcu_full(&rs->oldstate),
+		"A full grace period is not passed yet!\n");
 
 	/* Finally. */
 	complete(&rs->completion);
@@ -3247,7 +3245,7 @@ static void synchronize_rcu_normal(void)
 	 * snapshot before adding a request.
 	 */
 	if (IS_ENABLED(CONFIG_PROVE_RCU))
-		rs.head.func = (void *) get_state_synchronize_rcu();
+		get_state_synchronize_rcu_full(&rs.oldstate);
 
 	rcu_sr_normal_add_req(&rs);
 
-- 
2.39.5

