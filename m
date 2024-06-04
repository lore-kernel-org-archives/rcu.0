Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6916C14291B;
	Tue,  4 Jun 2024 22:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717539448; cv=none; b=TUlSFuBg3XQe/JIQQvrjwmQT+CJ33HGNHjME8cn+ocpGEfXA8yW+pVcjtjnQYKMA2IyL+RkpbWOvR7TksVnYTdMQfUk4g3XcvPqsgHGdVu3Mm+Q65d6dtZ9Z3CntIXuEXNGUN4JPmXgWKCsluFGei2molzXrC7HAq6aeEFFPmuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717539448; c=relaxed/simple;
	bh=ZIi9NsGl2kkv77Ig50dtYfPwTUZatjE3etHVnz+l6EM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cpzKLAAGzLl3MqCUiBF8t8147/mphKSQ/HaLFkF5EY5AtI3pN+eP6slj2EgWH51qnfZBkTpRIpXoVmGf5M+UhqVfeEJuDmwibv3vz73YgqGAK2jdLURGHORKZUKjZA0oP0ItO59N1ZXrF45gp4YgslesE+kSey0ErhsQ1UslvrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6ZTD0Oi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6ZTD0Oi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00CF2C4AF09;
	Tue,  4 Jun 2024 22:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717539448;
	bh=ZIi9NsGl2kkv77Ig50dtYfPwTUZatjE3etHVnz+l6EM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k6ZTD0OipHvArrul0MhGb3LgsksiEcVb8CU901fJXMNTP6LfxmzRKVkLq5fIidmvL
	 TN54lyMcMm9BeSzHPneTzNdrFAXkZ3wPt+c79/RgJHUHEw09MEhswavbKd4cY7fYXK
	 7c+II3ZGteeLwYxXlC6uxuGqHHX4ac+QDrU2z1QWwEnXMkE2R+8Lwb6HN6UeCy0aGx
	 pZot4NKHzjpvcmD29wwxYKT1YJ9kwQafZ/Npk6f8VOEOarW5lk1H0vb90wMO8JVo/x
	 oX4t0lXynwwd+YM1jrBFhEN/Rvt8dm9tkblXn8h8xaBtBNXjtBM0QOGLyHUCjDI9FK
	 iMG3xMponbp4Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 96BC3CE3F27; Tue,  4 Jun 2024 15:17:27 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH torture 4/4] scftorture: Make torture_type static
Date: Tue,  4 Jun 2024 15:17:26 -0700
Message-Id: <20240604221726.2370316-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <0b6e7177-5620-4bb4-832e-908f871b081d@paulmck-laptop>
References: <0b6e7177-5620-4bb4-832e-908f871b081d@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Johnson <quic_jjohnson@quicinc.com>

Fix the 'make C=1' warning:
kernel/scftorture.c:71:6: warning: symbol 'torture_type' was not declared. Should it be static?

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/scftorture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index c20c6eb8389d2..44e83a6462647 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -68,7 +68,7 @@ torture_param(int, weight_many_wait, -1, "Testing weight for multi-CPU operation
 torture_param(int, weight_all, -1, "Testing weight for all-CPU no-wait operations.");
 torture_param(int, weight_all_wait, -1, "Testing weight for all-CPU operations.");
 
-char *torture_type = "";
+static char *torture_type = "";
 
 #ifdef MODULE
 # define SCFTORT_SHUTDOWN 0
-- 
2.40.1

