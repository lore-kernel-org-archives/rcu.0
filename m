Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C89F143888;
	Thu, 30 Jan 2025 18:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738262838; cv=none; b=J46UZOuCLzXjGQYH+/16HEMtb5wLsxRX/VznJ0KAQdlQnicv4WE1l3/uakqGSJ22G7zs9xwu1gwJdDMFFVfcqvDqQCGIMmKbawbqudKbRSN3gLUEZaLmVvU6iVbl2wDZm+rlFF0ruVrcnw+HMvaKUlQzNnqALwZK4onx/6GuHYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738262838; c=relaxed/simple;
	bh=mO0BDH3xrBjWL+GG6QbRvlcmocAxAxKTN3pUlaCyI4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u1Mo3ktVxSl5YFCLBooa53YdlT3kSjMXrnSGl5uah0qd2vk1apEvTjmC4kEUS5YgDhjAPzGmA25uQeIk8l9y4wZt1NJJw9xyASaz9vvOsDuZrG796sh6T0RE0YUlgZD1wIi7IkCuzj8VuDairT8S/ZgQEkYIQdXQmQCYBpbjyKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iEKW205Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iEKW205Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6895AC4CEE1;
	Thu, 30 Jan 2025 18:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738262835;
	bh=mO0BDH3xrBjWL+GG6QbRvlcmocAxAxKTN3pUlaCyI4o=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=iEKW205Y4tYkA3B4E2CrlucABxSxr0t0HuRJeuSdpbUWLqVj3BM44wkDPDMm2enTb
	 Vqmvf1F2BykuZ0IkQg8KUoeNHHU8qpn8gH5ttlYVAqRkem4lBrxcDft+MmxmiSqJX6
	 Y8YVYhzGPJtj8KbQzv1AawLjbmCo1C+O6uMxBgnGFyq5zow9kzawx7FM+WfjxzFepR
	 UOykG9fl20p4Z59Q/wrC5Dqi5/t54aOkDbKFYepiQlq9J5D6v10jiXzhYdCM7Pqu3K
	 0OeL772xo19eQsLApnz385Tdq46811fNQVsYmqTqsTaa+P3fnqu7cdRSfE/bn0Z5yJ
	 8RvfugYvvlzBg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 04220CE37D9; Thu, 30 Jan 2025 10:47:15 -0800 (PST)
Date: Thu, 30 Jan 2025 10:47:15 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: Re: [PATCH rcu 0/7] Documentation upates
Message-ID: <851fd11f-6397-4411-983b-96f7234326d5@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <a2c2793d-771a-436e-8c42-4cb38def0e2f@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2c2793d-771a-436e-8c42-4cb38def0e2f@paulmck-laptop>

Hello!

This series contains RCU documentation updates:

1.	Add broken-timing possibility to stallwarn.rst.

2.	Improve discussion of this_cpu_ptr(), add raw_cpu_ptr().

3.	Document self-propagating callbacks.

4.	Point call_srcu() to call_rcu() for detailed memory ordering.

5.	Add CONFIG_RCU_LAZY delays to call_rcu() kernel-doc header.

6.	Clarify RCU_LAZY and RCU_LAZY_DEFAULT_OFF help text.

7.	Remove references to old grace-period-wait primitives.

						Thanx, Paul

Changes from v1:

o	Apply Matthew Wilcox feedback on "Improve discussion of
	this_cpu_ptr(), add raw_cpu_ptr()"

------------------------------------------------------------------------

 b/Documentation/RCU/rcubarrier.rst        |    5 +----
 b/Documentation/RCU/stallwarn.rst         |    7 +++++++
 b/Documentation/core-api/this_cpu_ops.rst |   22 ++++++++++++++++------
 b/include/linux/rcupdate.h                |   17 +++++++----------
 b/kernel/rcu/Kconfig                      |   20 +++++++++++++-------
 b/kernel/rcu/srcutree.c                   |    8 ++++++--
 b/kernel/rcu/tree.c                       |    8 +++++++-
 kernel/rcu/tree.c                         |    7 +++++++
 8 files changed, 64 insertions(+), 30 deletions(-)
