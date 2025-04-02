Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBC723BCE0;
	Wed,  2 Apr 2025 14:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743603129; cv=none; b=EnrXKBrr3Ofsayp6AXxc7SmU8J06Fj1uGCcErAQ59YjlBzhgPpc5hPQnR49r4ReZCZDxCw2hCcD3RQR8FjGrRiXE04u3cKQPizRUjrIJ6Y8YPSQaTTY8CZKwf4eF+1Jplte3EUTQmlWlMP1HLsoX6MOpDsEFgPlBLC5vp6aZn9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743603129; c=relaxed/simple;
	bh=PVRPqr/BtL+masoenUwjEJdENPdv0i8K/nXz1oB6Sek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+4a0XL/eEZK6js1eGWtSSV5aNBNEVuSZb8PWZd/59djZdr9f7Bd63AmXtRx6EkEsN4HPdjdw3dhTBcPQrDGTDcHuUW9lrGRzMj9PUuiNBUTnhWz5Gb0bgrqPSD1xRktC3eW8EdQwmDzHynsHWvP8n+XCEoi8IabiOuqZm7kARs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=neKzBAz7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="neKzBAz7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B8F2C4CEEB;
	Wed,  2 Apr 2025 14:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743603129;
	bh=PVRPqr/BtL+masoenUwjEJdENPdv0i8K/nXz1oB6Sek=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=neKzBAz7Eh9ln2UtxSQo7H916Fwuy1/+IdT4ICk2lPa/zVAa4pZ1270VuZipw0hZ4
	 AhYbnhCjKwjGsrQcjn7OE2Nfuf0K+Nk+X5ExEqjIU0NZQ1BBXTKGugbQwToOunBbcq
	 nRMOSqNBdUcAmVjzpnzLgaF+WQc3pyOoNnsUy0Oupqe0Iiib8pycBKEtgXJwgFzbAw
	 rJUcOuHXmKlUqOFi0YMtzRFSf95URNm4B5Y+AilTc64NwBpnmy5WjxXHl0GFOcZjQz
	 0MnyxSPFk4axPg+KWkoM7B2I0S5GhbThDmfV3IrgRyvcSbd1rN3KJ3aTLU5yWBxhsj
	 Oqdl6zDVumqbQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C8A88CE04AF; Wed,  2 Apr 2025 07:12:08 -0700 (PDT)
Date: Wed, 2 Apr 2025 07:12:08 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joe Perches <joe@perches.com>
Cc: rcu@vger.kernel.org, Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH v2 10/12] checkpatch: Deprecate srcu_read_lock_lite() and
 srcu_read_unlock_lite()
Message-ID: <611ea05f-e7e7-4983-93cc-ee2995250e91@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <eea8d42f-6d2d-485b-9bb9-4eb77a0e1f95@paulmck-laptop>
 <20250331210314.590622-10-paulmck@kernel.org>
 <5588e91ab302e21bf4e30b5208cf3d387f8e7de4.camel@perches.com>
 <0cbd404a-856a-4bc3-ab76-eeb839065a2d@paulmck-laptop>
 <d03ed9d9f7d5e9d8fddca4071e044d26c55a10e2.camel@perches.com>
 <62ef3d73-1a33-4357-925e-9c2fdf1ac8fb@paulmck-laptop>
 <18c590c303e23b90efaa698b2e21017153c1945f.camel@perches.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18c590c303e23b90efaa698b2e21017153c1945f.camel@perches.com>

On Tue, Apr 01, 2025 at 09:49:11PM -0700, Joe Perches wrote:
> On Tue, 2025-04-01 at 21:23 -0700, Paul E. McKenney wrote:
> > On Tue, Apr 01, 2025 at 08:48:44PM -0700, Joe Perches wrote:
> > > On Tue, 2025-04-01 at 07:05 -0700, Paul E. McKenney wrote:
> > > > On Mon, Mar 31, 2025 at 11:53:25PM -0700, Joe Perches wrote:
> > > > > On Mon, 2025-03-31 at 14:03 -0700, Paul E. McKenney wrote:
> > > > > > Uses of srcu_read_lock_lite() and srcu_read_unlock_lite() are better
> > > > > > served by the new srcu_read_lock_fast() and srcu_read_unlock_fast() APIs.
> > > > > > As in srcu_read_lock_lite() and srcu_read_unlock_lite() would never have
> > > > > > happened had I thought a bit harder a few months ago.  Therefore, mark
> > > > > > them deprecated.
> > > > > 
> > > > > Would it be better to convert the 3 existing instances?
> > > > 
> > > > Both are needed.  The point of these checkpatch.pl changes is to prevent
> > > > other instances from being added.
> > > 
> > > If those are changed, why not remove the prototypes & functions too?
> > > That would stop more instances being added no?
> > 
> > Deprecating it for a cycle then removing the prototypes and functions
> > seems a bit more friendly to me.
> 
> OK, please remember to push a checkpatch revert or equivalent
> when it's done.  Thanks.

Agreed, and at the same time as I remove the prototypes and functions.
I expect that to be during the 6.17 merge window.

							Thanx, Paul
