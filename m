Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3BC28EC1C;
	Wed,  9 Jul 2025 10:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057969; cv=none; b=WVEqrwoOdRB3NDZ/ZX2VdcfR/dWnGG5vVyrthuO9lPpLV3hLIuHDSj1LeCBP2BwI+rphrcfNd+hZVYlRZYLCO1l/SNN/dXsjakCDjLUNi7Ue6Fy2EInhidEEssyiVQ2bO4T1dkUidIolckV/nwt+abdplRCc4x6DoRHmHPtnTUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057969; c=relaxed/simple;
	bh=iAcwKVA/T/miVYGymUSSTNuPJn4ESmM99Z9BnTfFpPI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rECMURG0UekELtWAHYsGkHXT/F6g5S6OgPfGjWmKghOvQsIKcZcUv079G+qDmYTaA6hieLV/B5h0dbkaHnnI3PMbeuOWIfm4vLV5gq9XmEi4DeYhWrKBMR7vZFRz2tIBSbC1KHmD2Eyv5SuvJeSq8m2HXdeYXm+BEOL7rfrza8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9VoS6OF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9VoS6OF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE5DDC4CEEF;
	Wed,  9 Jul 2025 10:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752057969;
	bh=iAcwKVA/T/miVYGymUSSTNuPJn4ESmM99Z9BnTfFpPI=;
	h=From:To:Cc:Subject:Date:From;
	b=a9VoS6OFW6oF/C18DVP5a7fTOzfTyNrYXCsRGe8Okble1EcAsaqm/PhxYDrIH8tEO
	 6V7OU8fH0WAhJlurKl+xdyKJM1znyT8dl21rQLykblLkYkPpuIeSGQ6ROnPFv3Zyt7
	 R+d1OsHocue1f6ZOrbi2yMcXP4AugL64bjAIMTWcJ1poIqwVqg0LrNWmIOLbKIRcuC
	 gZf6FPmnj5XiXNrzDyDqgvlEmgF7vjjNJ9gXWtaPUSloGOpBV/zUYkngPVulVQ3bzE
	 LEix7y1Q/ORuV0iUp2U/Ow+YTvhYEaOH9jVhhiElAE3FgyehVfBh9WqLY8sKoYi2CX
	 LjSQrgkVBq2VA==
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
Subject: [PATCH rcu 0/3] SRCU changes for v6.17
Date: Wed,  9 Jul 2025 16:15:52 +0530
Message-Id: <20250709104555.15670-1-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Neeraj Upadhyay (AMD)" <neeraj.upadhyay@kernel.org>

Hello,

This patch series contains following updates to the SRCU code (rebased
on git://git.kernel.org/pub/scm/linux/kernel/git/neeraj.upadhyay/linux-rcu.git
rcutorture.07.07.2025:

Paul E. McKenney (3):
  srcu: Expedite SRCU-fast grace periods
  srcu: Remove SRCU-lite implementation
  checkpatch: Remove SRCU-lite deprecation

 include/linux/srcu.h     | 47 ++--------------------------------------
 include/linux/srcutiny.h |  3 ---
 include/linux/srcutree.h | 38 --------------------------------
 kernel/rcu/srcutree.c    |  2 ++
 scripts/checkpatch.pl    |  2 --
 5 files changed, 4 insertions(+), 88 deletions(-)

-- 
2.40.1

