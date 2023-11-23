Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F43D17FA
	for <rcu@vger.kernel.org>; Thu, 23 Nov 2023 02:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A1hi1EX0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B217EC433C7;
	Thu, 23 Nov 2023 02:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700707665;
	bh=rRbIXqjq8DKBA6vW+7glleky65j8TQodsqrm6IeWtY0=;
	h=Date:From:To:Subject:From;
	b=A1hi1EX0h5fEjOBb74Wjx+JglaZ4ErNKzTR0lHyT4lsPefGvN0EtcCWYweK71QmTT
	 cDes1HERJKQm0WBWVDwzOYcYmr8zkEEQjvltv7BY7/75tG/JgDd6cbOjJV8fQvslfJ
	 mAu4NhRmnKt1Xe6WkYLPVjG6D2S1NbWyBmhU83wY=
Date: Wed, 22 Nov 2023 21:47:44 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: rcu@vger.kernel.org
Subject: PSA: this list has moved to new vger infra (no action required)
Message-ID: <20231122-mutant-lyrebird-of-stamina-728016@nitro>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello, all:

This list has been migrated to the new vger infrastructure. No action is
required on your part and there should be no change in how you interact with
this list.

This message acts as a verification test that the archives are properly
updating.

If something isn't working or looking right, please reach out to
helpdesk@kernel.org.

Best regards,
-K
