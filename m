Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8BD144D01;
	Fri, 16 Aug 2024 04:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723781209; cv=none; b=PW7KZCftiEYov79ADTnbAr4lQog4XPMMme3YTY3KPlDD+Idw8HzUo60JzaBfyUpB6KerrRUWCCkLVrEkKWORrnxJC0ZnWQ5yIi+m1g1NslwB6he04sRBBWP38VboZlOlUxsZS24SroiVB6DmCfLpQZf3lhd1xOdHgztH+ScE4m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723781209; c=relaxed/simple;
	bh=oGg1sTOOfik2DIsN98TerQ4lcdNiCmH/sdT5tuPDOKg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oBqTUQNW1TT6HBb1JSvpiN3lLVGF4lSupAe6Jokkb4X7vgYQKHETuhoBf0xla7b4oa6kHCKT0rkkSQ7JaTzOcyWDt87MNkKEO1f+Ti6oWmjSE4WQAi6NURt3RsBl6iiuY+MvdF79E9aMOfjBcf2JZiWLRRU3eQG/nwLqpFjHD9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qiRQZR7C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qiRQZR7C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7E70C4AF12;
	Fri, 16 Aug 2024 04:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723781209;
	bh=oGg1sTOOfik2DIsN98TerQ4lcdNiCmH/sdT5tuPDOKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qiRQZR7C/op9ywCAK4rWBIAea4GQQv8G3Cj5hH9DFoTEvMDvoeVr8cN46mdwbsouD
	 aATEm8ul/wFm2Kruw0JxwbIS1DDan+bJGNG9KXYkCCEAECaHQI0cCWvxU4d5X8OBaQ
	 6CVcoS7PoO6FzkAHIX4gZOHGkg1zrGanTUsyRZB8pOz1x5uJumqAl4ceQliS3z687R
	 2b7IG6pHVB0fSl8AG6PuvM1kML486tdzfz/coghizERU0TVNzsPmqZo0x98R7KQX6m
	 yB1MX/nhfqs4TXqoYmVrabEG7yjUZuJM+I7tN9Hutwpy1TybTDfwoaEDNQWd2Z+jv5
	 GMX8bjGm8dY0g==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	paulmck@kernel.org,
	neeraj.upadhyay@kernel.org,
	neeraj.upadhyay@amd.com,
	boqun.feng@gmail.com,
	joel@joelfernandes.org,
	urezki@gmail.com,
	frederic@kernel.org,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH rcu 26/26] context_tracking: Tag context_tracking_enabled_this_cpu() __always_inline
Date: Fri, 16 Aug 2024 09:32:41 +0530
Message-Id: <20240816040241.17776-26-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816040030.GA16986@neeraj.linux>
References: <20240816040030.GA16986@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

Force context_tracking_enabled_this_cpu() to be inlined so that invoking
it from guest_context_enter_irqoff(), which KVM uses in non-instrumentable
code, doesn't unexpectedly leave a noinstr section.

  vmlinux.o: warning: objtool: vmx_vcpu_enter_exit+0x1c7: call to
    context_tracking_enabled_this_cpu() leaves .noinstr.text section
  vmlinux.o: warning: objtool: svm_vcpu_enter_exit+0x83: call to
    context_tracking_enabled_this_cpu() leaves .noinstr.text section

Note, the CONFIG_CONTEXT_TRACKING_USER=n stub is already __always_inline.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 include/linux/context_tracking_state.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index 0dbda59c9f37..7b8433d5a8ef 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -113,7 +113,7 @@ static __always_inline bool context_tracking_enabled_cpu(int cpu)
 	return context_tracking_enabled() && per_cpu(context_tracking.active, cpu);
 }
 
-static inline bool context_tracking_enabled_this_cpu(void)
+static __always_inline bool context_tracking_enabled_this_cpu(void)
 {
 	return context_tracking_enabled() && __this_cpu_read(context_tracking.active);
 }
-- 
2.40.1

