Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075A928DF31;
	Wed,  9 Jul 2025 10:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057720; cv=none; b=cG3uKMh7opZTBx/SupdDdXvpKg1S8ilSvfhLbkKFa3XntNdQj1X20ni6OpN2WeLIZ6pTtiTC3D2bBErRMvJCRdf7sNzThDEB0g3q641cPup9gI7FixVKLVsNvFUd4/2iD2joGfuSMLHUzSrysF8KOYGhKP3KPzQLekobFqIdJe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057720; c=relaxed/simple;
	bh=1ak+ddk3PY8OyM/OOq41y2PAuJg1y6QU46hpsXxpyMU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ctUR65lJv6Fm+hmaCsUS4OSnJf1g9L7G3kFGhT0yHA7GRHtRYwQIZEMa2LNgMTai0p2c+Epc5eO7oaTdeNed5rj33tW06W8XZ9ti4TZ+o4bWAAyDBg5XUJf3nj9m4w8If2fEqj1JItvoQzKFQ7Fd86TfVbf47ZemzHhLbvJtNiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sLmooCTK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sLmooCTK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57723C4CEF4;
	Wed,  9 Jul 2025 10:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752057719;
	bh=1ak+ddk3PY8OyM/OOq41y2PAuJg1y6QU46hpsXxpyMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sLmooCTKn9KtC14IgonQpFWfXmWit/XjYARFd1Iy/zuEapOqFBndL5gY1kW0BVOPb
	 0K0Af+pIHhfgO4Zt86wyFUt4ToWb0Evu6fh1+eNzhM2uCvz/f8CkGuhoZuZU65BKQN
	 WCw2RwUVWEjzmAvAlJYeolz+owd7ZmZhLECLWe0uCXt+n0hO1d19e4VNOcllyghH4a
	 2+m69q55ibM7bjR3vkYoOUwMNRheAfb7Ey0mzUzpR97d6PEHGGSPy2zR3eYsACGxpX
	 q4OpF2z155BpFuVsb6GLXfmRvicIAsdATCai2Oxcf4LEFXCnhasZKOhPM20BiZ98L+
	 4EmpL5uel2afg==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	paulmck@kernel.org,
	joelagnelf@nvidia.com,
	frederic@kernel.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com,
	neeraj.iitr10@gmail.com,
	neeraj.upadhyay@amd.com,
	"Neeraj Upadhyay (AMD)" <neeraj.upadhyay@kernel.org>
Subject: [PATCH rcu 4/5] Documentation/kernel-parameters: Update rcu_normal_wake_from_gp doc
Date: Wed,  9 Jul 2025 16:11:17 +0530
Message-Id: <20250709104118.15532-5-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250709104118.15532-1-neeraj.upadhyay@kernel.org>
References: <20250709104118.15532-1-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

Update the documentation about rcu_normal_wake_from_gp parameter.

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.upadhyay@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f1f2c0874da9..f7e4bee2b823 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5485,7 +5485,8 @@
 			echo 1 > /sys/module/rcutree/parameters/rcu_normal_wake_from_gp
 			or pass a boot parameter "rcutree.rcu_normal_wake_from_gp=1"
 
-			Default is 0.
+			Default is 1 if num_possible_cpus() <= 16 and it is not explicitly
+			disabled by the boot parameter passing 0.
 
 	rcuscale.gp_async= [KNL]
 			Measure performance of asynchronous
-- 
2.40.1

