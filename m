Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F64198848;
	Wed,  9 Oct 2024 18:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728497103; cv=none; b=ZlHAAEH0sngEWGATQOJRBmunQbvwzDtPIWx3VdK5BXJIbuVdmPsmk85nQ8BIAGeI3aZTOPXjHL/pzfQG02XKTyZJTA2CTYglmHJPkqX3MuYP1THgi2FHztGzdjV1oJ83yhwp3X98ASkmyyxDuCFAmAt8vrvW907K6qM/nEjQad0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728497103; c=relaxed/simple;
	bh=xi5Vf4qPLDOZg6aS2gIZseZylxrILYO/CpEUWdm8mlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nriMjpKUI2fWMBVDRJOuLUQbZ1WFeytwjhfPfe7EreL0XV026/JRaXy9SKQGlAzFT+HIK5265IbZ2ZnGrLyHHGgw8p3M3zmvZBugi0zqNm0EaEjHMdxBV7mZOdGaiH+Uv5paPFpssFTdwjqMNd1FUxmBycHb11S1CrxzNhuU0Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hvt6T1hy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvt6T1hy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B90C4CEC3;
	Wed,  9 Oct 2024 18:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728497103;
	bh=xi5Vf4qPLDOZg6aS2gIZseZylxrILYO/CpEUWdm8mlQ=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=hvt6T1hyNEL1uxlkPjGlDCtI6roQXixWWnPyXZS8MnZg4XFu2ftSSsyRihY4LXua6
	 psrj/+hbV3X41lJkktdLdyHjroor992NGh6AZdZTzrS/vs5Xi0mW0RKOA2VlVQKufA
	 /6+SzqkGb2Y6HmQ3/jLPuwxiRF4bt/Kw46WMdJkqawUqnqTR/C0w55YQ7wyvCJ2ys5
	 OG0T7MCFAYoZTpYrmvDQ/IgNwBrSXI2ES8gRfr3npGg7zYv8zZJAs7EUYgOLtk/QGp
	 sfvdN8Kw8Cll09JMDU+DJGegwNhGCgZS+HrHrRL+gdBxx2DmrYOBXYcuwV2+pbs/St
	 9jWByB5ieY3hQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id CCA2BCE08E5; Wed,  9 Oct 2024 11:05:02 -0700 (PDT)
Date: Wed, 9 Oct 2024 11:05:02 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: frederic@kernel.org, rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH rcu 0/3] RCU CPU stall-warning changes for v6.13
Message-ID: <fb0b7a92-d371-4510-80c4-25a57f2c4f3d@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

This series contains RCU CPU stall-warning changes for v6.13:

1.	Delete unused rcu_gp_might_be_stalled() function.

2.	Stop stall warning from dumping stacks if grace period ends.

3.	Finer-grained grace-period-end checks in rcu_dump_cpu_stacks().

						Thanx, Paul

------------------------------------------------------------------------

 b/include/linux/rcutiny.h |    1 -
 b/include/linux/rcutree.h |    1 -
 b/kernel/rcu/tree_stall.h |   30 ------------------------------
 kernel/rcu/tree_stall.h   |   35 ++++++++++++++++++++++-------------
 4 files changed, 22 insertions(+), 45 deletions(-)
