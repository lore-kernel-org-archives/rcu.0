Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A846D16EBE2
	for <rcu@vger.kernel.org>; Tue, 28 May 2024 17:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716916142; cv=none; b=I1uaSwqviJXZBtcuJhPh2/f7Gappk6P67+43nPFNXfN+kktLYy1HpIIW36Us63LZ+RKmTKdMtmaBv4d7NquhthxuF2HNkRg8Asm7bh/dMKk4Gi1EHSFp3OEItJuaydf0HDONQ+ltPC3GUu2h4SQch4KgTSHX4dS3LpUYMQUkYGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716916142; c=relaxed/simple;
	bh=TKmhwl7JkRAnYhg1uR/QpnSCta1x4/iuCjSVHO9ulMI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YHyH6BunZG726lAWzhQgzHcQB7+Ba0bWY6PS8528baiuf3yQVEUJI12XgYraVcUQEy5/MlpcuxIjmsu8qKITDYOCYyvLijAzLoYznwR9UxFI7LpmhMOan1uzGZTrMrGcs5Bi9w55sXYk0zrI9lLRF2Rp+OMTwJXAOjSicLyHYdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZJ4MdPs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZJ4MdPs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C243C3277B;
	Tue, 28 May 2024 17:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716916142;
	bh=TKmhwl7JkRAnYhg1uR/QpnSCta1x4/iuCjSVHO9ulMI=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=JZJ4MdPsnVc+dSG9WyGCv3KjnVw4V2yWCWTDcShLlWccD707AZTQ9DC5HRyLUxdiX
	 J4O8vyFl/DQO1m6kGG+xyPD5q7VUB9Va5ISFTuRCDZ5nWK9LRM3W7lpw/TsJjeIcRM
	 gJfxesBkMe95Glzno5naJRYI66jEr1yI29/opYQ33nvecYv57LnfWys2gIvxMa1dr9
	 E3PuVb7vHSc60DOPwmixMJqXXDgaEkoQsltE2MZcgdDb8ZBIUBeomZqwRZEdO9K9Sb
	 eFODVvI5Mk3vtN9tB8Hy1+LRnsNXIkvEsiUf40DbsmKgrxBQVdI8syFc3amVlpYWQu
	 XT/xh0S3pIgFQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B09B8CE0F8F; Tue, 28 May 2024 10:09:01 -0700 (PDT)
Date: Tue, 28 May 2024 10:09:01 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: torvalds@linux-foundation.org
Cc: rcu@vger.kernel.org, frederic@kernel.org, boqun.feng@gmail.com,
	urezki@gmail.com, neeraj.iitr10@gmail.com
Subject: And the v6.11 pull request will come from me
Message-ID: <9ad62150-b699-4662-9b7b-89bfdbf6a8e6@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello, Linus,

The v6.11 RCU pull request will be coming from me, in part to avoid my
getting too far out of practice and in part because the pull request
will be coming from our shiny new shared RCU tree:

	git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux

We expect that future pull requests will be coming from this tree, the
exception being when we are bringing in (or, in the case of Joel, back)
a new member.  Part of the preparation work for getting permissions for
the shared tree will be sending a pull request.

I will give you advance notice of any future new-member pull requests.

I will continue to send you non-RCU pull requests from my own tree.

Please let me know of any questions or concerns.

							Thanx, Paul
