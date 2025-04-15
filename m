Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A8825DCE6;
	Tue, 15 Apr 2025 21:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744751718; cv=none; b=RHiL38v//K5u74tV+z9xby8fznnKC7O2PtxuevqmFwIoEcQYoFDmML/AbyCEWy7r9S9Y4Fkh5Qnq66D8aD8M1L+lSRKq54HHO6V+9Kasr2XPhkrWiUMRYyhmMhiJPtmPCc64gfK4h4LTzjiiQYY4lWCc39d/6Nxwb9naI9FJOaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744751718; c=relaxed/simple;
	bh=tlkahzfdxTrBctXrZv1z/g+G+WCTBEE+T1vImdfReCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BpA6rpkGmn1UK4FUDRqOTeQ3ZxUgyjV5R6NfT2TyffmmtKRwLC9es/76bHct/4JEH6yFgg2O2qIfI1ynRUO29z3oZgsOaAIBkqnQRfqo/Q61mcq9Xg79/zEd8oaco5NsFOR1Osx58KvnUp9sc6gA1BffHg+BCRnqK7Zh1Eva5JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1S9855O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1S9855O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DA29C4CEE7;
	Tue, 15 Apr 2025 21:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744751715;
	bh=tlkahzfdxTrBctXrZv1z/g+G+WCTBEE+T1vImdfReCA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=j1S9855O3I6d5rK8H377b/RWT2Ho21hOyDVMWk3yX+zr2xHeN+JtvomuplD0uXJsn
	 QgxUpuoW5qhGIX1dlD6pZNAZ5CY0pTZykSnUt2N68udEbibaSAB+7Xl0aDtVT6F9KO
	 CIRfZy/1NP2TEslBYt0XkMFNMaB3918uYRitIAI7/hGU+r2wdZJcdrusRgoc3mG+Pw
	 0KXTcDBI3ZJ8PXCGxfLJ+GjWE91opAK4lpC2oeCiJ4skQsJHtjknaJvq1mzZUM3qW5
	 jcT0z23bz/A10WD97V+bCWKICt91DRzX25je5Mam2EqDSA9BrDE5wmXxo+5F/z6q9j
	 iVlKjFmoimTRA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1448DCE0592; Tue, 15 Apr 2025 14:15:15 -0700 (PDT)
Date: Tue, 15 Apr 2025 14:15:15 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH v2 05/12] rcutorture: Add tests for SRCU up/down reader
 primitives
Message-ID: <1d60ee60-2924-433d-a9b7-726f82f0e546@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <eea8d42f-6d2d-485b-9bb9-4eb77a0e1f95@paulmck-laptop>
 <20250331210314.590622-5-paulmck@kernel.org>
 <d40885a0-b0e3-4f13-a2b3-41ee2defbde0@nvidia.com>
 <37400faf-8d31-44ef-b9d1-6c91fa19b4f3@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37400faf-8d31-44ef-b9d1-6c91fa19b4f3@paulmck-laptop>

On Tue, Apr 15, 2025 at 10:59:36AM -0700, Paul E. McKenney wrote:
> On Tue, Apr 15, 2025 at 01:16:15PM -0400, Joel Fernandes wrote:
> > 
> > 
> > On 3/31/2025 5:03 PM, Paul E. McKenney wrote:
> > > This commit adds a new rcutorture.n_up_down kernel boot parameter
> > > that specifies the number of outstanding SRCU up/down readers, which
> > > begin in kthread context and end in an hrtimer handler.  There is a new
> > > kthread ("rcu_torture_updown") that scans an per-reader array looking
> > > for elements whose readers have ended.  This kthread sleeps between one
> > > and two milliseconds between consecutive scans.
> > > 
> > > [ paulmck: Apply kernel test robot feedback. ]
> > > [ paulmck: Apply Z qiang feedback. ]
> > > 
> > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > For completeness, posting our discussion for the archives, an issue exists in
> > this patch causing the following errors on an ARM64 machine with 288 CPUs:
> > 
> > When running SRCU-P test, we intermittently see:
> > 
> > [ 9500.806108] ??? Writer stall state RTWS_SYNC(21) g18446744073709551218 f0x0
> > ->state 0x2 cpu 4
> > [ 9515.833356] ??? Writer stall state RTWS_SYNC(21) g18446744073709551218 f0x0
> > ->state 0x2 cpu 4
> > 
> > It bisected to just this patch.
> 
> Looks like your getting rcutorture running on ARM was well timed!

And could you please send along your dmesg and .config files?

							Thanx, Paul
