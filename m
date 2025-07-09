Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE0D2BEC59;
	Wed,  9 Jul 2025 10:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057987; cv=none; b=ql93YfilohYmCWibkUEGXblAsxq30oc2HPLEcayA1h6BpkXkhE42P2kIkSeXH4a0KX2yfH1WIaIAdA7xwJQTgkz8d8CDM99FcZ/IsbliIIbep19oU9n3xn1MPVWLVlqWudYteyoR1aAeIvdA0z+EoWjoeVcchU+Ic9BmqALtaRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057987; c=relaxed/simple;
	bh=veBLTiqmKh7HkHet5CeS+nsL/ZR/56a8XiR132mTNUk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d0W213uTs+Kbi5j59+RpegzT0ji1cnvNDAgxg9FsADtf98e1ivAV10kU3cEHRdaIG2upEWpMzoW9bdFXccpUtOuHyJBmSmAYod7ZlONBuJbqfLKBxrj3dJS2LddU+mTAvUlFyQj7KlRhu6Qa6ixX68FmJaEBKDEiwVRr8Ggw7Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gthqMnjF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gthqMnjF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F41DC4CEF4;
	Wed,  9 Jul 2025 10:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752057987;
	bh=veBLTiqmKh7HkHet5CeS+nsL/ZR/56a8XiR132mTNUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gthqMnjF13Z+Ef1e7xBr/DeiXLTsDB9PZRwBDoJAhySLcahsMGyTcJvXyRJdqSccJ
	 0UQeqVLCQgqMJPmmXgcC9ntJu4Uhk2k4OGYVfwk6eImqGedFd8vVSjaxhIUaqcGoTW
	 xoh5CnxPhHPx7in45Kdw9+CwOHarlmIta9GjCziF/5X2fTEFm5Xtl9FwuL3B/Tw7I8
	 6hA/oEL3+8wrtehS6Um13T+tECpzBjxHHatIpodNZILdXxZU6Yrms4/3e/cqSS6CzH
	 W8R1ETSrM5VckJ+zSagXeatlrB9hSdxyQPpGkkgluVKamc8Le/Uz+5kVqk51Y0NQh6
	 QTirTzflNzZ/Q==
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
Subject: [PATCH rcu 3/3] checkpatch: Remove SRCU-lite deprecation
Date: Wed,  9 Jul 2025 16:15:55 +0530
Message-Id: <20250709104555.15670-4-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250709104555.15670-1-neeraj.upadhyay@kernel.org>
References: <20250709104555.15670-1-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

Now that SRCU-lite has been removed from the kernel, let's remove the
now-redundant deprecation from checkpatch.pl.

Signed-off-by: "Paul E. McKenney" <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.upadhyay@kernel.org>
---
 scripts/checkpatch.pl | 2 --
 1 file changed, 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 664f7b7a622c..867c7b6fd839 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -857,8 +857,6 @@ our %deprecated_apis = (
 	"kunmap"				=> "kunmap_local",
 	"kmap_atomic"				=> "kmap_local_page",
 	"kunmap_atomic"				=> "kunmap_local",
-	"srcu_read_lock_lite"			=> "srcu_read_lock_fast",
-	"srcu_read_unlock_lite"			=> "srcu_read_unlock_fast",
 );
 
 #Create a search pattern for all these strings to speed up a loop below
-- 
2.40.1

