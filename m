Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFD815E5D3;
	Tue,  7 May 2024 09:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074577; cv=none; b=j1B6PgCWpkfKzjUD0dsWR5BU6vU709IdXKOG3Ccy5myPRXuTS8fswLy6XdTU58y87iO3fWEHq+XCQL2h4c6SBoVfEKxMl3HMu/LEw3UxeAmC7UYaTLywtFm+CWTjTAMEwVqpzeZKvOudfckQ4Hm6nuwA+9g+do9+6TVQWBLbHz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074577; c=relaxed/simple;
	bh=2Ovb4QazW6xz+ZnbPbv0Z7w0+7dCSRlGQn8IFZIJ2m4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=URdPXV/44zWDtMGa27YOlulG+P4lKBGdqOgdDPcKPkGHNpp5CdwNvIOHMa71/CTMj2O+mJFu6mn8iGo1o/BmooPZQiFuElwR8FAN3TJZId9wWlyheVCI7NaW+T0lF93FG9BnGrj6w9T6oL/hZXuwktJASaLwN+SHswfCtn3w1Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bl8sOfUS; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bl8sOfUS"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e2c70f0c97so36453441fa.0;
        Tue, 07 May 2024 02:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715074574; x=1715679374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Mu7OuPta/bPwR0Ew9sS9HB7xqXazraEBV86ZqklXS4=;
        b=bl8sOfUSRVaRWPQDPPXJGemF6bNrYoaxcDAnpcZpNjd3qubgf2JutEhJO5GkiBlU63
         LVGMjc7kicDYXMmp3vpwq33kJrjiK02bMZmEPPkwF6SLzCF9x38eOpUse/TYhkdsVsj9
         vOe2pJFtB5UrWTOiXL1hO93ycwqGp8OtKvWCNNBS9vOL8xaZmHOy8ljaFIWFoMQp4aMR
         Z1r/fEezdt/ZMiVnuqOBYH2q7pdCX2+EzZ1wZ+Hydvm3j4BNHQ4nuQrZz58uzgN8X5pE
         mG9Y7SuWFPT43GpzNq2zBNCyjQrAKfrf2j/8hqq/Dw3NRxabOGK4s8LAuoiSep6GQRgk
         pTIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715074574; x=1715679374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Mu7OuPta/bPwR0Ew9sS9HB7xqXazraEBV86ZqklXS4=;
        b=d2PIYlMrDR4OxYcghb6ATRHuYp7YjyWFGR20NGMAJLTqi5o3WFlrbysmbtBIvOURR8
         mtyQ66kB6wKP6UE7eVwj+xSVo+Ll4IkwGuXsvnAPwaLtXDqA/vRp9MzPGWO7hJTE+p4g
         5JLs3i4dUs30RpRDkTd2F7UuAY6V57nd0Xbq6oiS9g9mDw6DtCehRmH6jyeQ/+ywLD8w
         3NoyM0IliHOOSu5aFl0ruzwfaPxniDn3RegZkzXYQKuDqtuRHCb090OmjC6NkFx7LlIi
         m1Z/TvG8gQ7yLiPvfH4biNZptWgWfvUYDGaFutCJBOLhAJZqrCmIZb15LmFveMBs5ED5
         ECNw==
X-Forwarded-Encrypted: i=1; AJvYcCUDYL2X8R7vWyM5N6y+jqFBE00YW8gQtn++cuivUN7S5tvTx+p4/vsRVfSZcHf8+j7Z4BAcpzw88FImRykyhlZ6r1VSYrNayzOSTix9
X-Gm-Message-State: AOJu0YxQdVlDEazGMgOLCBzeE2QBhaXaweX/+hlvuNE2toDgGr9UN7AB
	oqxIVeCNl+LIwe1qmavZcbHrhYnigejyANy4eidHQCN83ND/Iwm1
X-Google-Smtp-Source: AGHT+IEP4HpLK+/xx6R5D2NqSB6q2z5OIZlj2Z3l4ywCZWpsP83riqqtHJpBHYV83ocXwDL+7Qifng==
X-Received: by 2002:a2e:bc02:0:b0:2df:fa4a:ef15 with SMTP id b2-20020a2ebc02000000b002dffa4aef15mr10847723ljf.39.1715074573942;
        Tue, 07 May 2024 02:36:13 -0700 (PDT)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id t18-20020a2e9d12000000b002e29c50c4dcsm1335473lji.27.2024.05.07.02.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 02:36:13 -0700 (PDT)
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
Subject: [PATCH 42/48] rcutorture: Use the gp_kthread_dbg operation specified by cur_ops
Date: Tue,  7 May 2024 11:35:24 +0200
Message-Id: <20240507093530.3043-43-urezki@gmail.com>
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

Despite there being a cur_ops->gp_kthread_dbg(), rcu_torture_writer()
unconditionally invokes vanilla RCU's show_rcu_gp_kthreads().  This is not
at all helpful when some other flavor of RCU is being tested.  This commit
therefore makes rcu_torture_writer() invoke cur_ops->gp_kthread_dbg()
for RCU implementations providing this function.

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/rcutorture.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index dd7d5ba45740..2f43d31fb7a5 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1589,7 +1589,8 @@ rcu_torture_writer(void *arg)
 				if (list_empty(&rcu_tortures[i].rtort_free) &&
 				    rcu_access_pointer(rcu_torture_current) != &rcu_tortures[i]) {
 					tracing_off();
-					show_rcu_gp_kthreads();
+					if (cur_ops->gp_kthread_dbg)
+						cur_ops->gp_kthread_dbg();
 					WARN(1, "%s: rtort_pipe_count: %d\n", __func__, rcu_tortures[i].rtort_pipe_count);
 					rcu_ftrace_dump(DUMP_ALL);
 				}
-- 
2.39.2

