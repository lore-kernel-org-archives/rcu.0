Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71D44A35
	for <rcu@vger.kernel.org>; Fri, 31 May 2024 00:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717115668; cv=none; b=q4M6UKH+BkCKjYh77QxWYykEuSthsTrDiBfzy0HO6RGnZZXXd6XarfkgX1pCG6gPG7tllsdu2R9ubE0k8wGda9EKbYXxF6J/JIxhAmaqU2NA47BmFyH8Rsa0q3EEwM04yNkkRcjuQU0WZ0SfpyeVhPngvNCgTvrtyblLMDjpl5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717115668; c=relaxed/simple;
	bh=ZOeyOCs/E/avRdUX3VpiefkGkWNjFVSrU5AAVygwg2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=reDUp3CZkhe5LsT324O0yEHfJub0vwCMt7CZHFhlisQncHzD+s2Xjs1DRm3sk9zBvV0i63OGeB4Kf474j7YUPLODPexHyB92p/rVGY8xXbMrBogkoGuMjMW+SUej0eIFqJLuS790wMNi1ZrQ5TC/B4D9C+cQKE5Jvypb4L1pvog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezFzSlZg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezFzSlZg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D49EC2BBFC;
	Fri, 31 May 2024 00:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717115667;
	bh=ZOeyOCs/E/avRdUX3VpiefkGkWNjFVSrU5AAVygwg2o=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ezFzSlZgqHRmzcXg7Ddcns8Iou4D8m9BtuXtkKOg7kZe9fefoT9v4wKEfcPDDFJ2X
	 YwM45vttPR8ondn3Hv0iSRqDeE6bLox4aPYfFtHHVEQfKB6r/oqQ7gnpilaSrViJRK
	 XebFahxXvSB+2NPq008DGTgOku4zVK0u0oG0Ymkbq6JX/RUDxNeM3uBdaVf/5wfL+7
	 zRRq+7yMil3oPN5/ItX4lkF9rvfye9lNFzbkmNlda4IOdWW2dGXuioBwZDv8UF1pa4
	 LX67QCuHN9SOdMFPL5rOG/2PRZryJMjQGNFdJ8M1S/WfRyyArdvXBvhPCs1YdecmJn
	 ujq/932GHdy0g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B32E4CE0B6F; Thu, 30 May 2024 17:34:26 -0700 (PDT)
Date: Thu, 30 May 2024 17:34:26 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: rcu@vger.kernel.org, frederic@kernel.org, boqun.feng@gmail.com,
	urezki@gmail.com, neeraj.iitr10@gmail.com
Subject: Re: Updated -next branch and repo for RCU commits
Message-ID: <0bfe0a90-76f3-493e-91ba-7997b6da43d4@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <9ad62150-b699-4662-9b7b-89bfdbf6a8e6@paulmck-laptop>
 <732c43ae-6d7a-4a98-995e-e96086a94678@paulmck-laptop>
 <20240529080212.21a8ab42@canb.auug.org.au>
 <0cb42d29-4c2e-412d-82af-0f2e42b40669@paulmck-laptop>
 <20240531100550.664ec884@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531100550.664ec884@canb.auug.org.au>

On Fri, May 31, 2024 at 10:05:50AM +1000, Stephen Rothwell wrote:
> Hi Paul,
> 
> On Wed, 29 May 2024 15:21:05 -0700 "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > 
> > Please make the newly renamed paulmck tree pull from "non-rcu/next".
> > 
> > The additional contacts for the new shared RCU tree are:
> > 
> > Frederic Weisbecker <frederic@kernel.org>
> > Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
> > Boqun Feng <boqun.feng@gmail.com>
> > Uladzislau Rezki <urezki@gmail.com>

Thank you, Stephen!

							Thanx, Paul
