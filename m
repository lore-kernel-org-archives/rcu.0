Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCB5283FC3;
	Mon, 21 Jul 2025 16:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753115075; cv=none; b=G2YvRATo8mqqQiswukoAqD8VjO1GSuAOES5Xly52EeVP9UPn6z3uVHUjErTrJ4QE0N3/wMg9vuNJ6crxScpaJkPPuUmt0ujGOo1t4jBVR0f6OJqbWEbZqx5UlqoQ02vYVShk9t4QmmuyckqDHT4XPVhmpJ+xP+EME1ZiwyMdOWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753115075; c=relaxed/simple;
	bh=BlaBOIkXVR5xoqsab95nUX5wZC2ogd2y9wiA1pKiHvc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZNKPtOZ4k++z3D49DPgK1Gs24lMjapod5hyD/fjOq4SGUBbGqgGlcZPp67bIOqf++IhK/Ifp7x3umV6e9yUajrwHxSSs0/3c6TAkiUWRqfVbS2kPpkOQ/EysbESKgFlzihzGuiDln0xOGxf9wCO9nVGpGxEae+V1xE2LD15A5sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMU+GxNy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMU+GxNy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B7DFC4CEF9;
	Mon, 21 Jul 2025 16:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753115075;
	bh=BlaBOIkXVR5xoqsab95nUX5wZC2ogd2y9wiA1pKiHvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mMU+GxNyXXdWdUG9kGhuq7GFpbXjwvHwvJ0zmAmXfIERL6R8AhFxEHSTeyE1t+jhV
	 UkCBtHksg3x2KISLZCgWfZPrXVOD54O37RxDtvIndgcxUATz6A7DqCg+oRhuGYX99L
	 zE0XMUmQEknfwjBY+G9Hl989Ye1laOLfkWghQrvPWqfaiuUo+ni90ynyUmwIj5rWse
	 JCI4V/RIT1r5+VuxGmaTg/TRl2kZonvl0fAKAyAxNetfOO8t3tpCs7OeOQEn5ocfMi
	 /3GKZufahpP101Uh8ayWclRyupvS+9DqSqqTsIYdHZWlH90i2MK3GcY+p7Np1T+Lqh
	 OSJg+kHJ3vpsA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 11B9CCE0D3A; Mon, 21 Jul 2025 09:24:35 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v3 3/4] srcu: Add guards for notrace variants of SRCU-fast readers
Date: Mon, 21 Jul 2025 09:24:32 -0700
Message-Id: <20250721162433.10454-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <7387f0c2-75bc-420d-aa7e-3a9ac72d369c@paulmck-laptop>
References: <7387f0c2-75bc-420d-aa7e-3a9ac72d369c@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the usual scoped_guard(srcu_fast_notrace, &my_srcu) and
guard(srcu_fast_notrace)(&my_srcu).

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/srcu.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 7a692bf8f99b9..ada65b58bc4c5 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -515,4 +515,9 @@ DEFINE_LOCK_GUARD_1(srcu_fast, struct srcu_struct,
 		    srcu_read_unlock_fast(_T->lock, _T->scp),
 		    struct srcu_ctr __percpu *scp)
 
+DEFINE_LOCK_GUARD_1(srcu_fast_notrace, struct srcu_struct,
+		    _T->scp = srcu_read_lock_fast_notrace(_T->lock),
+		    srcu_read_unlock_fast_notrace(_T->lock, _T->scp),
+		    struct srcu_ctr __percpu *scp)
+
 #endif
-- 
2.40.1

