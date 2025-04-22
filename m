Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB0614C5B0;
	Tue, 22 Apr 2025 17:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745343517; cv=none; b=m06QRKmXkXWWGEcfWlozMv0GJXIiAU4phoy+H/vuwLPAJO/0yZUfTGt5FDbAY40lzVeQW83FiYssHE5Auvryj2VRVDyf4+IVdTdte7euQLK6YPr8vbPdAbnTcXO8MC8kWa5zXqd1fcbVCRuXGbZQ8BIqUZIR4vEVD3EhzHcr2Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745343517; c=relaxed/simple;
	bh=HF24HNO95MNROtw0V39vSpb5wlUyjvQBx6UQxR4B4QQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N8/yXBTU8rn23oyeX1jHEHaVnkSYwr/qhjSmJDtCXR00OcLRsGV3I/7PAQJOFZg6OXx4vJye7y6jL8wQAg3ueMoEaxCe8L4nZMnDY9/EW2vmz//zFh17ezteTEe5dHowrJ1HJw8blcFr53nBRVy5ThGnHLwkiSp2KEtLKN5YgHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GV/0eJ3e; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GV/0eJ3e"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-54af20849adso106566e87.1;
        Tue, 22 Apr 2025 10:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745343513; x=1745948313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l1+j+IdcksuK+qQNWIasP0Bg2j3cB09bwCOtDQN7Szo=;
        b=GV/0eJ3eFLxBxxCHETk3XiUVg9CLwswuyrmijj0ySJWkoQxss9ZVuz7ejVDx5W5/1H
         FSiIcFDeEXLO6vAXGI3slGu85j+Pb+vMpF1r08CXzWJ97pTeLNc3x8xPS6wR+RhGMgYd
         i2zQn0PCbQvO1jmshRsvxRD7yClxKsWq+hZV7ufnxknbxLhhcm3ICQhzDjJiyPfAvZNU
         zzzMFopc6Ge1QO1BbXch5r1dps6GwIOhW72WsrN2MElrYOrL+1j4yVxmCDkMa69/RqBy
         1fZswJqQE6xLDXvbptl6Ho/5jaOSD6q+ReTNVUB0OMmYpPNuBGqqfG9tIKo4vOoQvXtY
         6Sog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745343513; x=1745948313;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l1+j+IdcksuK+qQNWIasP0Bg2j3cB09bwCOtDQN7Szo=;
        b=ghYYZ2UQyoy/3EltEN4SbNtXmw5sx8ycKTaEPUg4dWXCaCHd5d2XDdR/gBSjA45Plx
         Jfjii/JFG/nNzTz9eDeak+Xuw9R9a+UOqwohIi5F1wPbfjS5kDU1yPN4mzTziVNwRk1Y
         9h799FqdST1Uh9CDwtTxqNbm/ePSLDXZA6g/BMeVpMBAhCr9qFtTweEy0ch6ciW7kIQj
         W6VQsJWh/8fX6UPJ3iFhW6S2AEH3Own2HptCTmETvKzJYV3E0/Uozx9lsIKTJF4kVqcQ
         fHk8455IJiw/ScS7K9qAG/Mx9eAaTKMCj/q92E1AXpsGLOBvY3CARro5eL9svwDNRYjo
         Li1g==
X-Forwarded-Encrypted: i=1; AJvYcCXUcmyGM4NOER+2ByT8pFra98JoV7KGq9lOE4CzJB6KF5+hXY2b6qL7o59HEebSliN8jWC908R8QbeGifE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6PPT209ipT8cei9slFrAUkDS1w2BEKFZQDO4+iGj1xcPn8nfT
	gE/nNZw8BNBJ1idjXOSbbUXCB8kZHnJmrkdjqUFczFSu35v6eN2F
X-Gm-Gg: ASbGnctUh3PHn55xkDkhyssvjfHLFAiZkGSU8Lz9qbajBDEA6/awaUjUVNV/JbIPwHJ
	hF0+ap0MT5ktsCQcUvXIG4ZUAFbfe+plZSIYE1cHXu7S/kYZdGQUS754oBCMcNC5/wPuM/kZJXf
	60qtIvpvw5Ze/8cj6g/mGcTJOYE+xLu+/0GA3qfery9UU/cQ3ThDeo4DX4YEwECICdlFp1rGtqk
	PQFCBYOtKBrOzBxTtc/p3zmr4Lu7MYsQHhrRdYcBbt5GYy+YxBQzSAUC+gZmk1LuMcBYSgvmr0a
	b7OjivlEmLAdYkk74r8YFPe/kLhcTKmIsh1n
X-Google-Smtp-Source: AGHT+IH5mQqhUQdoRpL4pAHXMmRMqdhXweQ+XMI8zApEmHef+y5nMSokXhsgsSezIuFQsgT9XuwGVQ==
X-Received: by 2002:a05:6512:2c85:b0:549:5769:6af6 with SMTP id 2adb3069b0e04-54d6e77ffa7mr5807141e87.9.1745343512976;
        Tue, 22 Apr 2025 10:38:32 -0700 (PDT)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54d6e540b79sm1300640e87.68.2025.04.22.10.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 10:38:31 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>
Cc: RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH] tools/memory-model/Documentation: Fix SRCU section in explanation.txt
Date: Tue, 22 Apr 2025 19:38:30 +0200
Message-Id: <20250422173830.90647-1-urezki@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SRCU read-side critical sections describes the difference between
srcu_down_read()/srcu_up_read() and srcu_read_lock()/srcu_read_unlock()
in a way that a last pair must occur on the same CPU.

This is not true, the srcu_read_unlock() can happen on any CPU, but it
must be performed by the same task that invoked srcu_read_lock().

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 tools/memory-model/Documentation/explanation.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
index 6dc8b3642458..34aa3172071b 100644
--- a/tools/memory-model/Documentation/explanation.txt
+++ b/tools/memory-model/Documentation/explanation.txt
@@ -1896,7 +1896,7 @@ following respects:
 
 3.	The srcu_down_read() and srcu_up_read() primitives work
 	exactly like srcu_read_lock() and srcu_read_unlock(), except
-	that matching calls don't have to execute on the same CPU.
+	that matching calls don't have to execute within the same context.
 	(The names are meant to be suggestive of operations on
 	semaphores.)  Since the matching is determined by the domain
 	pointer and index value, these primitives make it possible for
-- 
2.39.5

