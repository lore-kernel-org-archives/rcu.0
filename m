Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203DDF9EB
	for <rcu@vger.kernel.org>; Wed,  6 Mar 2024 17:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709744629; cv=none; b=L803wi/Cq0Zej7G0kryxpKIJmA4dALdWw24QPDrtYyIYs41jthjl1fM/zZOpaCP4yX9W+3OQlyEGcfmAbecQiDgOjeYLJhjdTdhbtPOrxVX+7a4ktPu1Z940C/SHG+FgGcW8VErros6Po1czcFsavl9ZzjFWkib+F3pe6lurzuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709744629; c=relaxed/simple;
	bh=NRusRR8jX3oUi6wjO0+t2dI8FguAhnQlYXDu5zi1YwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U8WaQbKBzl9S06C2i9X6rO9zI9aQscIvVChqgTJxdqlSDOKqeqxu7dz5debNeY9lJuj93ymvEEMTwPZsEk1Th+ifLE/JX6QGS14bCzw9pjLObFfrnaggjrNCs88TM2iv28jqAlkSY9Zp2YCf2EQ3xly6RrEllq6AC6Cv08tCLf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qHwXtVYO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qHwXtVYO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B1D6C433F1;
	Wed,  6 Mar 2024 17:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709744628;
	bh=NRusRR8jX3oUi6wjO0+t2dI8FguAhnQlYXDu5zi1YwA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=qHwXtVYOpE5aExWPykszVt89NqeWX4+02KI5ifGpP85YZMrPJVs38sPmRzhOeLFnN
	 aZWFWTM9BbIokrTIcXaobxP2Ysyh0PQA/64dN6/BXbWZY6OxbQsG9oer+7vP3R32VT
	 nJOme+IkQhsn/+X9z8MVecUQRV9xoHs+lfO4E2QryZeDMAO4vJEKtx8R0I897zHvTY
	 XJoZo3AWJ2p8nLRNudbv5P4DsQqqWWPNMj2uWvGcEyKeOFbJudX6OnN42lu1eG4hHe
	 t0vLm2bzicHjRgy548tFqHYM1qoMJCoMOzD9c9gJQFdC5ujmVzxEWA7xvVBWnycuiM
	 SxfoukKnisAyA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3DC57CE12BB; Wed,  6 Mar 2024 09:03:48 -0800 (PST)
Date: Wed, 6 Mar 2024 09:03:48 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: torvalds@linux-foundation.org
Cc: rcu@vger.kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
	urezki@gmail.com, joel@joelfernandes.org, boqun.feng@gmail.com
Subject: Boqun will be doing RCU PR for v6.9 merge window
Message-ID: <e85e7908-3d25-40ba-9931-917649d9a343@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <6a6d4007-e783-4dee-9f0d-6a1d2525a766@paulmck-laptop>
 <d9bab0d0-02a4-4220-88b0-3f9a86512bf8@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9bab0d0-02a4-4220-88b0-3f9a86512bf8@paulmck-laptop>

Hello, Linus,

This time, Boqun Feng will be handling the RCU commits for the upcoming
v6.9 merge window.  This is once again a practice exercise.  And again,
I suggested that I would be doing v6.9, but Boqun was willing to give
it a go, so why not?

Once all five have done one solo pull request, I expect that we will
move to a shared RCU tree on kernel.org, and I have already alerted
Konstantin to this.

This yet again covers only RCU, so I will be sending pull requests as
needed for the other topics.  Of which there just might not be any.

And yet again, please let me know of any concerns or issues with this.

							Thanx, Paul
