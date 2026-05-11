Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9709747B432
	for <rcu@vger.kernel.org>; Mon, 11 May 2026 17:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778522101; cv=none; b=uzgSXfHRHLm7TonMn7PzxILEwpxa/bOY8J03Breaz48xhPLqRVKgv1mld2l7ZUxFwXvto5Tp+pDVVgLEATWUcYkPekHFHcr2t2Dz7Li/nvsuMoXaIFt9jx1oMI7QuUJsT8XnSvs/xDCEwYhoNkkEM0aBSQ7wAAtXJis8zihKAdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778522101; c=relaxed/simple;
	bh=RkHk7z2ygyoyi1ilNEZkRX+Ty9Jdxo0cKjCdLWv4d/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CfzlYswD4b8S+1CBA/m9mlJzRbUMatpqi9L7iOym+EEJt9QImASHzvnVvHKfr5micd3nJEFoaW9Wh60nGiGYOoKUGP37s+/tPY73VOjTY9IL3l+n3hjxOVhpDzpYrPHDMuHbiAXr1kuIZcrzrlTEUfCVJQP9Lhfc6zhhzrcMO6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3sOBPcL; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3sOBPcL"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a8d1f43432so1662351e87.3
        for <rcu@vger.kernel.org>; Mon, 11 May 2026 10:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778522098; x=1779126898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HfDpEv+39iIZARqiCjGlpklYp+nlJJtKSY6Ud1S1ntc=;
        b=O3sOBPcL/gSNMfdxnbbG3+8C99s8vlSyT01BeGyCPngE8ZiWrf/zESoxVXGcBHzWRW
         2ZrJDCKZ5ZWQI9U2cWGeS1UCzPuh45Pr/2E0Sf1qbjp0/FrwM9K7gGngwZ+97QghSdYy
         XIWBcphllWB22ih/ql64HtFJpP/pI9mVLHJmp2zCEJJFkwj/tzpI7gGH6GiYQwkB4+oW
         plFPAX9cd8l/DveEM3J0NfK4phHRUSTclZPF3wCIhxtcH62SeO6KJIZKdxBZmqyoiddQ
         Dud2BjkfsG6a24pZzFFKRbOvIZqbNfUv7nT3lyLAdJdCNvpCm6ryyjGN0CvBfJU1flv0
         xYIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778522098; x=1779126898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HfDpEv+39iIZARqiCjGlpklYp+nlJJtKSY6Ud1S1ntc=;
        b=ckSN/Uqgu23wXNO7vdEUnWujSufVy5Lcjen3bHTjnNt6pkhFcFK7kvy86R9Rwcdvo0
         b6UKzF19GRMdaTKvU5SpstN6E6iIyBOvnDc1kFVwRXSWW17+A0wbATxIDPd/cKgwpbVj
         TZMgjC1qvUdCDUYilr5PyIriYwH5J9IvhgVmQJuOOyVf0fXc3iv7cscPm+xDmxRCCksX
         RFgML4QdyOc++sl7x8Hl363/GlGw8uS9wqlPLSV1Bm0fnzOJPAiQxv+H4FXIJm2iJNCU
         SW3bIUe3Yp4RZI4vLp07ze+m8ag+S4d+qBO2nHYKLr6MDcFPoqsm6zr27JDZ9J6oXfjA
         X4CQ==
X-Gm-Message-State: AOJu0YyLdEFVXGR1uhEysp3z563vzo364o+/W3HKMoI69WaOkv+Z48bn
	QQIaeunFlP9WduUa+5X2HaaIwNqz5vroYEZ6J15UG1MTEzWESgyGs/oE
X-Gm-Gg: Acq92OG29akm/zVoCuc5U2Mj/2KXTwskz8Z9GnjwTnxRRFQVgaOMzTM1kB1HGeaq87L
	tFNoPQT/BFbuNrurHNqbZamkKKcsZ7akxTYwPjkTSYVYmtQpzOtnAThg6NFfzPel/Da3rL97Hm0
	v942/TGAevUn0s4LSMrR5ygG65dudDerQqykiG0r7R1NXz6KKkH5OczijAByEn7mrqQs4zMc6f7
	MTkfUzpB4ebjfelhG2AvFZQRM8vbvkwljgCVPiYy6rN0TXnz9Mf8KfwON7v/qog0DR7G0k9beTP
	Y9yeXk3yD+MilWucyyUpU80zI55M5a/UxMdblLyYvFg3muDSpnP13W+7gOK1iVaB0Rh786iS9Pm
	gzEjU6Vq+OxfUL9WyHwxbYYGHcEI3lAUfYWGDkpCWfBke3ufcMw9HQeRCA0QpEfME9XPT1ZlWPO
	9qBvzJFAebYnclPQX1sww9WUZULA==
X-Received: by 2002:a05:6512:401f:b0:5a2:843f:5800 with SMTP id 2adb3069b0e04-5a887cde847mr8139783e87.23.1778522097566;
        Mon, 11 May 2026 10:54:57 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393f614a5f4sm28968891fa.33.2026.05.11.10.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 10:54:57 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>
Cc: RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Maxim Mikityanskiy <maximmi@nvidia.com>
Subject: [PATCH -next v1 10/12] rcu: Document rcu_access_pointer() feeding into cmpxchg()
Date: Mon, 11 May 2026 19:54:46 +0200
Message-ID: <20260511175448.153326-11-urezki@gmail.com>
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

This commit documents the rcu_access_pointer() use case for fetching the
old value of an RCU-protected pointer within a lockless updater for use
by an atomic cmpxchg() operation.

Reported-by: Maxim Mikityanskiy <maximmi@nvidia.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/linux/rcupdate.h | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index bfa765132de8..5e95acc33989 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -592,11 +592,13 @@ context_unsafe(							      \
  * lockdep checks for being in an RCU read-side critical section.  This is
  * useful when the value of this pointer is accessed, but the pointer is
  * not dereferenced, for example, when testing an RCU-protected pointer
- * against NULL.  Although rcu_access_pointer() may also be used in cases
- * where update-side locks prevent the value of the pointer from changing,
- * you should instead use rcu_dereference_protected() for this use case.
- * Within an RCU read-side critical section, there is little reason to
- * use rcu_access_pointer().
+ * against NULL.  Within an RCU read-side critical section, there is little
+ * reason to use rcu_access_pointer().  Although rcu_access_pointer() may
+ * also be used in cases where update-side locks prevent the value of the
+ * pointer from changing, you should instead use rcu_dereference_protected()
+ * for this use case.  It is also permissible to use rcu_access_pointer()
+ * within lockless updaters to obtain the old value for an atomic operation,
+ * for example, for cmpxchg().
  *
  * It is usually best to test the rcu_access_pointer() return value
  * directly in order to avoid accidental dereferences being introduced
-- 
2.47.3

