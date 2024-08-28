Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED16416C69E;
	Wed, 28 Aug 2024 11:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724843377; cv=none; b=Wbq6IaK8VnZAv47c0npAVxBklj45PqdG2kMYkMnTH6eDFatkXuyTzHS5irPLKgIgX2Bbdo6ZJVZiVBJRqRcp5wtaAw+lLJLjTgQ7jlAJHqsNXYXc+ACuudDSlOVTTvcPgaTmU2mmBbFGp2J+diexHQ48El8Ye74hE/e9F7iJ43M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724843377; c=relaxed/simple;
	bh=9m0pRR8yM71XVwtaS618iW83Vq3roJj72F+akL67EF0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fn+MSabBqXGFOCItKr0KbNopT3vsDRj3G7NGWPunTKtQ/Qts2hUtPYlKZo3AAb6jFXNw6LHX4pVe17Ko04AtKxZef1tR0AmqMOoIzjBr1CTxc8loxOs7dWreXF4X/hWg0DnaeF21lBsK41NtC+G2eg4eOgSsMwD97USDFPsn6Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gyqblZpj; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gyqblZpj"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-533463f6b16so7676602e87.1;
        Wed, 28 Aug 2024 04:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724843374; x=1725448174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PS1EedoxC9byua1+UZRVXRdvQLe+JCLGGMnsMTTpxko=;
        b=gyqblZpjekIkQhSY94RgFmZ03kCjDccC5u5h3ftAQmq7CtPOUvLKQ03snsxKVpJAJv
         2HTfP5F79OAwZaILoBP/chGO96vzXp4WgmtBg4SkcjiU5j9JGmqO7N37N+gVu7lA2+kB
         0Fmjvnychl+PVo1Hojmfbgx0kC8jtS3VyagXpg4rtuTX5y7PMCCLeri5WSeBNAG5c49j
         X0VVvLVjQDjiGyRjnvCr4EDiUWX7z0jkjyvb3EptMyB0HugyJhEGZeSUQg7agRS79GXN
         TgrwWrfV1STA3XLKttQrDwy3PszBop9Xw4rusVMCEu32/dCPTnx6WZQWHiu0CECDcZ8E
         sGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724843374; x=1725448174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PS1EedoxC9byua1+UZRVXRdvQLe+JCLGGMnsMTTpxko=;
        b=pAED7dHLMspz6oWbI3/DaEI+5Kc/3qnRKz3Eji5n994xBaKv07kdP7FP0ZKqlKIz9L
         +78RLa9ewMFVwRaqrpa/9ckAj8G3uKb7yWoPoWJEzTG/ovRgVkaDdsfZuqISfoB5IeKO
         JvIw7dhal9Q4m2oBnVreZEC12gY3svXAJ9KeFwzNdXUPmf3lF3CMGwY58qQ6Tmf2LkEH
         R6ihBcGseSh/6hqqeYgG4FEZn1Ycuy6MOLNgAqJsonP7BMqzNSUBFqj4d6B8D9elk6NG
         y8Gub3UxvV3XQbaaKESNBTQgj6X89nN6dh3qlQPvMhCuTuDD+6GrFXg6X1YqSkm+wpgI
         1K3g==
X-Forwarded-Encrypted: i=1; AJvYcCWpIll0Il5/NVVwzPoM5clHd5lU+q15HndsAOOUarBupl82OOfkq0n4a0mocVzUpgME/LmEhqvf85sCOz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqkBIJ48l6RxVvY3td2P/t8QHlfZNMBqXiT5gTe4PJVgy/idNX
	s1fcQWOTmv6be/PCZcIsVtwc9QehHbC5E3aL86fFiYy6IWKXm7Br
X-Google-Smtp-Source: AGHT+IGB1qGeW1U586SJZVS5KzpIMraDAHuHNngoxh0tTmQ7PKVY/n3wxUb5sqAblzNhU2DPsD9NcQ==
X-Received: by 2002:ac2:4bd1:0:b0:534:543e:1884 with SMTP id 2adb3069b0e04-534543e199amr2278194e87.44.1724843373443;
        Wed, 28 Aug 2024 04:09:33 -0700 (PDT)
Received: from pc638.lan (84-217-131-213.customers.ownit.se. [84.217.131.213])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ea5d6bdsm2154922e87.208.2024.08.28.04.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 04:09:33 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>
Cc: RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH 4/4] rcu/kvfree: Switch to expedited version in slow path
Date: Wed, 28 Aug 2024 13:09:29 +0200
Message-Id: <20240828110929.3713-4-urezki@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240828110929.3713-1-urezki@gmail.com>
References: <20240828110929.3713-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For a single argument and its slow path, switch to expedited
version of synchronize_rcu(). This version is considered to
be more faster, thus under a high memory pressure a slow path
becoms more efficient.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 030a453f36c6..835d90905ec1 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3922,7 +3922,7 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
 		debug_rcu_head_unqueue((struct rcu_head *) ptr);
 
 		if (!poll_state_synchronize_rcu_full(&old_snap))
-			synchronize_rcu();
+			synchronize_rcu_expedited();
 
 		kvfree(ptr);
 	}
-- 
2.39.2

