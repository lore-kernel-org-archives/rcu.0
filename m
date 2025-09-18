Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A16E2F5A1A;
	Thu, 18 Sep 2025 10:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758191395; cv=none; b=QvRQaEQIIKyGsrM5R9pw+kILbto3sLHx1MUF+6GDM9FkLPemJU4CE/IytUOMCD4FLZR/8eJOHkrIXb25IaldIYHKX+Rh9FP9Z9z8kB0rd1zCOZOGGSOIHiTGiG6/Eczn6i0zLYj3ePGnERGY2+hnXxEV91i2Wm2QKE0cc6Zywsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758191395; c=relaxed/simple;
	bh=jJfIUtEDWjKmTQ75RA/L6ODvVHBRzgs6f1hgAtKNxGY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EYo/wHe5/PFLgGNnFpO4SXkgAc4UqBfCSmWWS0Wo7tgXbPd4gkV+Jlt7bNlcvlokA5Qw/2IZn59vEXOEmD5JypTOxyoaV626NAMOM6qqEU27EXUMVTraDU8MvRunzbzuBYhI9eaOo6PQRq7PH3mg1RU3mIkWdnS9vPtFjLwvECM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJwhXw4B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJwhXw4B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 027DDC4CEE7;
	Thu, 18 Sep 2025 10:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758191395;
	bh=jJfIUtEDWjKmTQ75RA/L6ODvVHBRzgs6f1hgAtKNxGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YJwhXw4BB+lXH9Ljrw+98NSWWqZhKXL1lI1rZW+EfrwrBPJKpBX5zpWqOGR3NHyEd
	 cmTY2+hFcGiec0k5QagH/5EzA6bxn0W0e55cmdZsr3hyEzm6d/TjZKibOBVhJoZkfo
	 29FF8ZwLgmtWXOE6Qffq49WfU/VvmSbKUv07XqjefMQ0P2fsFOb8rVUWq5plGoWyfL
	 JOj+2CBp+JflMaW40W0WCVRoqp1zHW7WUc4zCbhs6sDPQQf7jZetv5BhEsJnungKxV
	 V518Apn+R1nVl5huqSvAfgqiI46ALVu2/wjzAEEzQosHrf7qQZ2a8FQ8DdsN6Kr4I+
	 VeC2SXJpYwYVQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id DA23ECE10DB; Thu, 18 Sep 2025 03:29:53 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 06/11] torture: Delay CPU-hotplug operations until boot completes
Date: Thu, 18 Sep 2025 03:29:47 -0700
Message-Id: <20250918102952.2593045-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <c0edd79a-f988-432c-b08a-18793b2e15d9@paulmck-laptop>
References: <c0edd79a-f988-432c-b08a-18793b2e15d9@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CPU-hotplug operations invoke stop-machine, which can hog CPUs, which is
not a great thing to do before boot has completed.  This commit therefore
makes the CPU-hotplug operations hold off until boot has completed.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/torture.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/torture.c b/kernel/torture.c
index 5abb4b25d971cc..1ea9f67953a766 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -359,6 +359,8 @@ torture_onoff(void *arg)
 		torture_hrtimeout_jiffies(onoff_holdoff, &rand);
 		VERBOSE_TOROUT_STRING("torture_onoff end holdoff");
 	}
+	while (!rcu_inkernel_boot_has_ended())
+		schedule_timeout_interruptible(HZ / 10);
 	while (!torture_must_stop()) {
 		if (disable_onoff_at_boot && !rcu_inkernel_boot_has_ended()) {
 			torture_hrtimeout_jiffies(HZ / 10, &rand);
-- 
2.40.1

