Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FCD1635A3;
	Tue,  7 May 2024 09:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074577; cv=none; b=HCBRAfG0un1F12tA80ln8p51VkVermgmIn/IA75g7zNPiiCSOYmNPgAYbTx7LGMPoXYSrSHJTUlh8xm9Eaw1nAhHJkIFACHWPfxMx1eysMJZr67ALAMGTt9SFr4MF8tmj8OpT80RAtHeZDOK58kF6LYFlzXlTuk2SGWgnSlWMfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074577; c=relaxed/simple;
	bh=JN0w1xsQGF3iE6mpueRmof2UMzcBsc+EhVwKMcjJxBw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HswU6R1J6MAe6tD+H/bFwU0Lf8ev4BCYMMHfrr3EIemevoJW2G/kN0/V8nHBmezGCui2fDWND6AEIEt69ogYSDOdMGi+w/AA6OnID/ALwxvjj7HMPKdhlrvhvDJfsWb45bFCD46n1h2CCZ8wWBhBdKbvXLadHx+Tc4HK/Rfbx74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehhr9sjR; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehhr9sjR"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e30c625178so25906011fa.1;
        Tue, 07 May 2024 02:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715074573; x=1715679373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0jO2a1vN4cs3B1CONKF++m02zLGls5jBFIdXQrkGHDs=;
        b=ehhr9sjRIk5M3KulSZb42g/O0DJgYMBU/BhFs8D4sGsmyF7anhtK7TU28OkK3Ab7vV
         cGxRIAkGa07p88mcNcJRm5f4BCDYkkYqUVZCAJ3RNzieeSXtNX5DSyPfXN0Uuc1BspJe
         C3jRBGam4QIDxpK4OU6KYzSGEtMM/QhSHKYHnsN7ZZ/zlBynZmUrX7asQ0KoZ1BgJFrZ
         Q/26QzH5LMaAj9vvb/nISdt4dm3Z+TtgATvol3ZXjkNWummqMUGysYYtecTQ3TwbP87M
         SjsDXbhqfZzJaOOmSSKpp16IUfmrM/3YRR7J/Dq+fOw9vbUJ+HuWB9xGR9JX+TjwQDh7
         jgNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715074573; x=1715679373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0jO2a1vN4cs3B1CONKF++m02zLGls5jBFIdXQrkGHDs=;
        b=V8NAR6qa2Y5DwRCD3qFnUmluBwit8LXrmn8wI7roL3ZaT89ZbowP6yngIkw9NEwuPD
         VGwPcUbDeekLGtgjYyeD9/JjwrSXE3nbTKhFjd/NbM4E6UnVib9/z1B0WWlWQuCt17fe
         IUEHpp4qkd+SBxu5/IAiEeX4NDwCknJKsb1JpQgzfA05K7DjOC71jyD9Uxo/a5azKEQZ
         GZijhWNlDrZfv/7BaUCieSpCM3S+Q0ZeeyFxvx+VyDLBy6EwTMiM/rhq6CK30YeS6kxc
         CyFbAzO4DqRaeKOxwTgvDnNMmVxXwtNLrCDU2heaiOHhYM3qgxuxvX1nkqVnIIAUeLT5
         7HEw==
X-Forwarded-Encrypted: i=1; AJvYcCX2WYXTzNUXgg3cHZQLC/jlI2utK+PKl2nDCGvJtccbPt8BXBr9zJQFoscryPJNss4H2bNEwT34NAFWa8N4Xb+bu/gsdSao0mLSHYUX
X-Gm-Message-State: AOJu0YwcL+5p/qrgGsiYgWKArj2MLKcw1ZnH/J4vpMWsYJKh48Lg0FTi
	oYFAV+TgUEhdHMWRrNFX72n5Nl5cqx1rRnU8b01RLHYw5e6UKKXO
X-Google-Smtp-Source: AGHT+IFMHiHJqIdDweja6wmqeVlqkX7I7JoUo0BkwXd63EadpeKgm7Wtp2NuplKHiNmK6c/Pt20L0Q==
X-Received: by 2002:a2e:800b:0:b0:2dc:d2c5:ed0 with SMTP id j11-20020a2e800b000000b002dcd2c50ed0mr7629467ljg.12.1715074573120;
        Tue, 07 May 2024 02:36:13 -0700 (PDT)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id t18-20020a2e9d12000000b002e29c50c4dcsm1335473lji.27.2024.05.07.02.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 02:36:12 -0700 (PDT)
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
	linke li <lilinke99@qq.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 41/48] rcutorture: Re-use value stored to ->rtort_pipe_count instead of re-reading
Date: Tue,  7 May 2024 11:35:23 +0200
Message-Id: <20240507093530.3043-42-urezki@gmail.com>
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

From: linke li <lilinke99@qq.com>

Currently, the rcu_torture_pipe_update_one() writes the value (i + 1)
to rp->rtort_pipe_count, then immediately re-reads it in order to compare
it to RCU_TORTURE_PIPE_LEN.  This re-read is pointless because no other
update to rp->rtort_pipe_count can occur at this point.  This commit
therefore instead re-uses the (i + 1) value stored in the comparison
instead of re-reading rp->rtort_pipe_count.

Signed-off-by: linke li <lilinke99@qq.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/rcutorture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 0cb5452ecd94..dd7d5ba45740 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -467,7 +467,7 @@ rcu_torture_pipe_update_one(struct rcu_torture *rp)
 	atomic_inc(&rcu_torture_wcount[i]);
 	WRITE_ONCE(rp->rtort_pipe_count, i + 1);
 	ASSERT_EXCLUSIVE_WRITER(rp->rtort_pipe_count);
-	if (rp->rtort_pipe_count >= RCU_TORTURE_PIPE_LEN) {
+	if (i + 1 >= RCU_TORTURE_PIPE_LEN) {
 		rp->rtort_mbtest = 0;
 		return true;
 	}
-- 
2.39.2

