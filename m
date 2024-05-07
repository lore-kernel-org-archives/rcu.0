Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB77152DE0;
	Tue,  7 May 2024 09:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074546; cv=none; b=cNtWipDS2QbLXf7l9vMzZPTrCl/DeHzCNlKfocY0/fpqETcFEc5g4FUe1cgGkYSq1RkL6jZmc8SXYZP0X/QbI3c9j5FcRBvM55hXA8JfVMHSaY3+7++5VWkFinQKesh350OrUFeFR0vBRqxb6vMGgCl7QEGInm5Xbi8/Kox2Yg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074546; c=relaxed/simple;
	bh=CEEiylPlq3j71LNCmuDby9KtGNd1YDAPS3GOOTnrKaA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=offROE2NN4JJU1Wt2DeckecRoqwGSZWovb4PLE09SHDGL/JiCH0gTPeyXGajjy2FuxTcHANf1P+BHIzV75nuWiC2V9JXle5x8DvwRj23ff53ySUdicYL4rcVBV/BkAX7YI4VjC3aKQfqzslDDpwG+6d4+OEUAG//necqxzlDALg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJ6BYvlH; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJ6BYvlH"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2e1fa1f1d9bso55702661fa.0;
        Tue, 07 May 2024 02:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715074542; x=1715679342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5OtpNZnclUijB37KVBOy2jnede7b3aa5kSGilAYif0=;
        b=EJ6BYvlHjDC+UDFuWuAMNZoZ4B1hDP9GpfiYixJ7rs2gU4QQ6ucLJHNBRlbeGfR175
         qGxmSOogECS0bfi81SrO6D9Ys5CJ9g8WvqX8dkavNkKHD5Naw4HDITo8iJYb8NGBO+ad
         DXgfuSAjrJWBcFZjp40TSPgb+hszukNEx4hacv2K6/lAlJydDZYhFUv9yD062XBFLi8a
         gsuFMVSX4jDba708+4U2dPwfBU19l/ls7wlh7r+AVuvbqjRGLb1FUH3xJxzRwabZRPpE
         4PUCDkK4ZfAJxya4eqnUxRGPxIZCpCxvJOQb8TGB6iIXNwfe9cAm3lT+PC0mPHl/myFq
         EC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715074542; x=1715679342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k5OtpNZnclUijB37KVBOy2jnede7b3aa5kSGilAYif0=;
        b=GtZFN72zVxKRT6aYRPj3LjnqLPZUijU5BTkT3hJKKGVfdIKTnOUuwbInNQHpKt3fSb
         r+IZdK6GRPKB2yoojWutjeCX45Vr/OOAIyQFrDhuqz3TgAHfSQ79hNlIengjcwO+IyGr
         S+zgvEBcl6w9wE88IFkrPN0xly7HJBBK8uhzoj5oLkN9beM9PwWvGxpmg24593fNrCSM
         YypG6cqJxNnBlsuzM3sdWsbmkm17/3L8qvP94WVhC08PkDzogAANG3M7VLxsXOxFwb2H
         RuGod8UivYIlF8BIY8PBMjTSA8WuvlY8e2cTrpLvGkhM5ZHjey8c+BQ0M3XZ75OVZD6z
         wNGQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1OuG17tc+6JrxyHhmLnzDg13CAyHysKkY/ssSKEO7jE1dGIp45+orrV6aF27/mdrrRN7Bdhg2tzqxZZ8Lxz409+eHuFsFTaq/9+xy
X-Gm-Message-State: AOJu0YzbtptiNxAiyB2VCNtIUTQhEVMQuVLs39cKt82ajBrlXdp+fBrw
	5Z6XQdCOxdtK3kxWJkSP6MnBGvJ6dm3t5TJrKXAGJXmNwdqoWTLq
X-Google-Smtp-Source: AGHT+IGNPUx/C384/inFDXioDn+uBYnBPZRb4XAF3oX/NOg6AfZ61TvDJvKeDlg2PdGyJStq53z3kA==
X-Received: by 2002:a2e:919a:0:b0:2e1:a2d5:62c2 with SMTP id f26-20020a2e919a000000b002e1a2d562c2mr10695933ljg.33.1715074542210;
        Tue, 07 May 2024 02:35:42 -0700 (PDT)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id t18-20020a2e9d12000000b002e29c50c4dcsm1335473lji.27.2024.05.07.02.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 02:35:41 -0700 (PDT)
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
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
Subject: [PATCH 10/48] MAINTAINERS: Update Neeraj's email address
Date: Tue,  7 May 2024 11:34:52 +0200
Message-Id: <20240507093530.3043-11-urezki@gmail.com>
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

From: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>

Update my email-address in MAINTAINERS and .mailmap entries to my
kernel.org account.

Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
Reviewed-by: Joel Fernandes <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 .mailmap    | 3 ++-
 MAINTAINERS | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/.mailmap b/.mailmap
index 59c9a841bf71..32e12c26bdda 100644
--- a/.mailmap
+++ b/.mailmap
@@ -445,7 +445,8 @@ Nadav Amit <nadav.amit@gmail.com> <namit@cs.technion.ac.il>
 Nadia Yvette Chambers <nyc@holomorphy.com> William Lee Irwin III <wli@holomorphy.com>
 Naoya Horiguchi <naoya.horiguchi@nec.com> <n-horiguchi@ah.jp.nec.com>
 Nathan Chancellor <nathan@kernel.org> <natechancellor@gmail.com>
-Neeraj Upadhyay <quic_neeraju@quicinc.com> <neeraju@codeaurora.org>
+Neeraj Upadhyay <neeraj.upadhyay@kernel.org> <quic_neeraju@quicinc.com>
+Neeraj Upadhyay <neeraj.upadhyay@kernel.org> <neeraju@codeaurora.org>
 Neil Armstrong <neil.armstrong@linaro.org> <narmstrong@baylibre.com>
 Nguyen Anh Quynh <aquynh@gmail.com>
 Nicholas Piggin <npiggin@gmail.com> <npiggen@suse.de>
diff --git a/MAINTAINERS b/MAINTAINERS
index 7c121493f43d..0370e571f312 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18591,7 +18591,7 @@ F:	tools/testing/selftests/resctrl/
 READ-COPY UPDATE (RCU)
 M:	"Paul E. McKenney" <paulmck@kernel.org>
 M:	Frederic Weisbecker <frederic@kernel.org> (kernel/rcu/tree_nocb.h)
-M:	Neeraj Upadhyay <quic_neeraju@quicinc.com> (kernel/rcu/tasks.h)
+M:	Neeraj Upadhyay <neeraj.upadhyay@kernel.org> (kernel/rcu/tasks.h)
 M:	Joel Fernandes <joel@joelfernandes.org>
 M:	Josh Triplett <josh@joshtriplett.org>
 M:	Boqun Feng <boqun.feng@gmail.com>
-- 
2.39.2

