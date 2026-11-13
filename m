Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794531476;
	b=QIwy4Z2Ws+oQAgsL7y/PxJDQdJHM/wv44b6Va+lm6KSEAOo36rphiGjD4ZGVvPNUEP9r
	 2dzsnFHrUnaShdyijTl4SKy+GBMPNhR+mog8Q8JLRyMveIqXu/cnYHo92ekkmSNG6FUkU
	 ifCFH5PNM265zgQKNLOgqEvhZ5tQWp3LXobqyc5kQJ/GH1v61kKArrI/IasElUW9n2UX0
	 kHswDPzWXdEj6W9O/vtodP/zxnPB2Vn1yGWWuOwIfj3nYP1DDcdG/UUc0GqKCGkXPc/qw
	 Q6oWxFitOAgZ3rFXB0vkRQZZtnVjpzMzAauz7BVwp4sHGCEV+MWgcZGluLHQCLyIypQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794531476;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mp8Nm+ZgjUiagLtuzyFv0b5XLhVofSDigIQqeI46CSQ=;
	b=fEaR5eCG6mrAbnUlqt7bYO1Kgm44G9Cy9HgeRtE3bAhA/36lntQvtamSJCn99D7DAfRW
	 kUqqs4ipEanS40dr8bhIT0xLMt0gdA+ED3rWh5PQ/e4iCdtwfHr7PP+dqDb9D2sHiWVbL
	 Cm0mjqgPLVpKXvUFpLDMb6bDO+svwFuxi4LLUtaABNtpzBOAXIABV/qbe024JzRu/MmGJ
	 jPbUFrYatNA7e/Gtr4RFDAyiaOU0NEEfmT2wCzGxjUrYr8LYl5s9tRmUHj8OB/eWN3rgB
	 ssKPAX3YzwszNWjeds97RpqM0lAoiXmETBaPflXnPrsZ7yKrIQxTZzJM6ucNlWvjapA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hp45uWNU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 810F4606A334;
	Fri, 13 Nov 2026 00:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hp45uWNU
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D04721F000C8;
	Fri, 13 Nov 2026 00:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794531476;
	bh=mp8Nm+ZgjUiagLtuzyFv0b5XLhVofSDigIQqeI46CSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Hp45uWNUlx5lB0g1PVku3oGagTt0MsHS6lj3WhUUxTU/sh90uSTmwJej9SWhs9KJC
	 Hm+EDQxGKsuT/SpE90FL0nUljOt4SQ50f3DQTpORlTjcMn1eGds/369qset1q1ilhg
	 YTnqJOmqo2upEg86MuCUcfvXyaRiaMhTduOXq2l06pteuFqveBX9RusOBL35DLuc4D
	 fbVJnHQ/myzneuQZRQhWLO24RwluZ22WkRwqWBcPwrWO/4HJyBU00Hxz2PsHVVxVxT
	 xeHJ3xk93ZyhE/reS5nRWxxiGYLEPh7FilrYOp3TLIqz9kZwOlzPvA3OjYi9oQ0sDp
	 Fb3qFXSyVB0UQ==
From: Joel Fernandes <jfern@kernel.org>
To: linux-kernel@vger.kernel.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <jfern@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: rcu@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org
Subject: [PATCH for-v7.5 03/14] kasan: Avoid an unrelated RCU warning in the callback test
Date: Thu, 12 Nov 2026 19:57:30 -0500
Message-ID: <20261113005747.2977123-4-jfern@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261113005747.2977123-1-jfern@kernel.org>
References: <20261113005747.2977123-1-jfern@kernel.org>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rcu_uaf() passes a false protection condition to
rcu_dereference_protected(), which produces a suspicious-RCU-usage
warning before the intended KASAN failure occurs.

The pointer refers to a fresh allocation that has not been published to
readers. State that protection condition explicitly, leaving the intended
tests intact.

Test:
Built with CONFIG_KASAN_KUNIT_TEST=m
Booted Qemu guest (8 CPUs), ran modprobe kasan_test filtered to kasan.*rcu_uaf*

Signed-off-by: Joel Fernandes <jfern@kernel.org>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
---
 mm/kasan/kasan_test_c.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
index b9e167ed5be3..4e23765d722c 100644
--- a/mm/kasan/kasan_test_c.c
+++ b/mm/kasan/kasan_test_c.c
@@ -967,8 +967,9 @@ static void rcu_uaf(struct kunit *test)
 	ptr = kmalloc_obj(struct kasan_rcu_info);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
+	/* The freshly allocated object has not been published to readers. */
 	global_rcu_ptr = rcu_dereference_protected(
-				(struct kasan_rcu_info __rcu *)ptr, NULL);
+				(struct kasan_rcu_info __rcu *)ptr, true);
 
 	KUNIT_EXPECT_KASAN_FAIL_READ(test,
 			call_rcu(&global_rcu_ptr->rcu, rcu_uaf_reclaim);
-- 
2.54.0

