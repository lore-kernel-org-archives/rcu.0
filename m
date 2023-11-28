Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BA563F
	for <rcu@vger.kernel.org>; Tue, 28 Nov 2023 05:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="naVbjU1g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF49C433C8;
	Tue, 28 Nov 2023 05:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701147823;
	bh=qKMtN0oxnfvYSPgXVOcM6YK9MPEfDyIQuxPEhjxBR70=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=naVbjU1g0Cv42aYwW4CWsqgKOwz41iOKoq1PKFxL2Rg4q556GBpDsSX3A/DMnKaTE
	 AAQMb6l11RggekZWo6rH2s4Slj5Iphf3cOS6hhYDPDuL9cr+BnAqYZ2t6cbJqKZyjB
	 dK8jYBHYnL//NuxAndobWSSKkINkbsZiQHCE79ANP3LMbV1Z6Bz5jzB5DBbkSosP3c
	 xSxnsSrlw+4O8ZrVboN/c4snDSiB/8ezIymXNaTdD9Z0gMIPKNgt2y0MZJAkZ6DOen
	 /FKyPWFbGQYHsEBhr3/0O+ufyHazeIouSZgnIPrPJg0o25H2tIuKY/C1c9bH/dKUmE
	 2KISIIXfy0wBw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 23DFDCE1140; Mon, 27 Nov 2023 21:03:43 -0800 (PST)
Date: Mon, 27 Nov 2023 21:03:43 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: torvalds@linux-foundation.org
Cc: rcu@vger.kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
	urezki@gmail.com, joel@joelfernandes.org, boqun.feng@gmail.com
Subject: Neeraj will be doing RCU PR for v6.8 merge window
Message-ID: <d9bab0d0-02a4-4220-88b0-3f9a86512bf8@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <6a6d4007-e783-4dee-9f0d-6a1d2525a766@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a6d4007-e783-4dee-9f0d-6a1d2525a766@paulmck-laptop>

Hello, Linus,

This time, Neeraj Upadhyay will be handling the RCU commits for the
upcoming v6.8 merge window.  This is once again a practice exercise, and
I will likely be returning for the v6.9 merge window.  (Yes, I suggested
that I would be doing v6.8, but Neeraj was willing to give it a go,
so why not?)

This yet again covers only RCU, so I will be sending pull requests as
needed for the other topics.

And yet again, please let me know of any concerns or issues with this.

							Thanx, Paul
