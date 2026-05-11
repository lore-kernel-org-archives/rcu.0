Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BBC477E48
	for <rcu@vger.kernel.org>; Mon, 11 May 2026 17:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778522098; cv=none; b=lsX9HQgbHTBsmc8CR86+eCLpZqHoEviTknQOCjnxAsdcp1bVkOszKKS9S0EoxgEu9yTFFFqdH7dkAYwTzUMoFhQ/Iy9kWVnT8PsfZU7eyoaUDA//0G4Cf13ubYwlwHL2EH5PzP1IZjRIV3/Pxx7Wy7C3sMLqf9S5iX/Z6kYbH7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778522098; c=relaxed/simple;
	bh=sCzlW8dI0Fhs+cB9tikStcBigUiohJn/nNVBfBD/Z7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qsv3wTfm5Jkzn3XFiOqxFy5lUPZNTUDL+Sona0eet4XTabmSxQk8nPmYrQARfeJKtiZ8hdoFA6LOK5e2Fvw8C7WBFT2wmPYcQT3jPpYIj8m9u201c7jtNFVe+F0TtduDQyySndPotl05B0ucg49pb3BArHGVrwuHEZ+8qK/5r78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MG4JWMcv; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MG4JWMcv"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-38a01c80c34so35720521fa.0
        for <rcu@vger.kernel.org>; Mon, 11 May 2026 10:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778522095; x=1779126895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/RJXFq6LqCe4pPTryrEabmW7igLHdURwee7mxbgIMM=;
        b=MG4JWMcvSY4DguR9zqc3dHmxllIx5xIjqDNoUybc8qrdklvB/ldeLjxkISMcc0eXlo
         t1hxmWICxMRMMjN7yfhFrcUR+J0ycb1QWCCADFiSs7V1agY7iVJfcTX8lyDAdqVJtxyA
         yXd/tAE8RcwUByA1SMJS8UszS/GUAc1gKXvxXNZHn6p2aw2VrL6l2ElwzZJ+RWvmuXX+
         kEGE3eeJJHjRZQhqLJAc8nydwFWdCYFEvwZerYxTpnniYRIg+Wp75qSM59LpzSqdEQ4S
         I/aTPAvamh2tG7zF86xa8vmDEeZbrao/SPSO2elaarUjEaHpniO97XyQdXOGidipXnFd
         CtUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778522095; x=1779126895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o/RJXFq6LqCe4pPTryrEabmW7igLHdURwee7mxbgIMM=;
        b=snPGiwjkQ9pXFiY+0gn//gB1iuWnm9kHHX9vvQ+7b8FNBGoduydN7gUAfaSTNxbX8a
         UXoigKktm7ZCnBq/G3CunAnj0tOxhaXKOf18nYUyplXvHhMVwjEVJfjVxe7XRWI3m0Xa
         /GicnCviOHSrX+l88D1cqNnjIJHOI0TI2+3S1IscASp7e7yP50sjTabmFUzBBvwA4qJ4
         cottjfq0toJ6CFmLcDF1fCXs+rlSPo9xd8r0p7V3kIUwh61k3Vz0U/XBkwem53hE6c8w
         +AGuLWJsAFr2Jl3hfZNFo0FCNuzQlvZ/AKxmATo29PP/1rr4infBgsXJ1o/S9vuS6jwS
         ODpg==
X-Gm-Message-State: AOJu0YzKg7pNMSOODtR7CEGpKG0OH+Z8WRXZZ/ohE8PA5Z7yI7JytUDk
	DsPuU6g4WUk+j572blLpeNkfRsmapWH0JM+BUCwnezzE59EhzTROrEsH
X-Gm-Gg: Acq92OFgYCDx2RLWvb6ZD+gU/gOwVFeqaXNVvGeOlbIX0iSz+QMoHR2SowpJf7pwdpk
	KFAZ6/a7jtwjovG9b+CvqVLqbG/V3B369qKIttevUFxYbvJDdWvGfCMLMAotiM6D7lEUl58mM9A
	9EHthe9j0UXTt6OcjTF8d2rvzA/Hz0zzf64rAELsy5na5vI3wKJNcOdAjvZpsZZFWPtU5Gxrl4M
	bvY5GmPkgivFqfMgaz+ovzhd1FbJ4oTzgotUq/aAmeOkc3Kt4F3HHrr+Rwm+BcETMNMIC7cN5e8
	NCCL4/y4dX5U4nf3pTqKsq9W9JKqeCLQ0WD0Ukc5kyKr2M42heW7Pd6gqvsk6evk+7LlK9AScHq
	oJ1z2NDiFS/5wu5qiih4R1cE6iYycrOSmYAK0LsVzTu/7zlCl1R0WqvTASRYOGnpUX6opxtoJNe
	9cTM2DZ/nK0vax7cJCPg0tB3dTDQ==
X-Received: by 2002:a05:651c:54e:b0:38e:e6fd:65b2 with SMTP id 38308e7fff4ca-39408132229mr34016011fa.21.1778522094672;
        Mon, 11 May 2026 10:54:54 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393f614a5f4sm28968891fa.33.2026.05.11.10.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 10:54:54 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>
Cc: RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH -next v1 06/12] srcu: Fix kerneldoc header comment typo in srcu_down_read_fast()
Date: Mon, 11 May 2026 19:54:42 +0200
Message-ID: <20260511175448.153326-7-urezki@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260511175448.153326-1-urezki@gmail.com>
References: <20260511175448.153326-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

s/srcu_read_lock_safe()/srcu_read_lock_fast_updown(), there being no
such thing as srcu_read_lock_safe().

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/linux/srcu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 81b1938512d5..a54ce9e808b9 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -397,7 +397,7 @@ static inline struct srcu_ctr __percpu *srcu_read_lock_fast_notrace(struct srcu_
  *
  * The same srcu_struct may be used concurrently by srcu_down_read_fast()
  * and srcu_read_lock_fast().  However, the same definition/initialization
- * requirements called out for srcu_read_lock_safe() apply.
+ * requirements called out for srcu_read_lock_fast_updown() apply.
  */
 static inline struct srcu_ctr __percpu *srcu_down_read_fast(struct srcu_struct *ssp) __acquires_shared(ssp)
 {
-- 
2.47.3

