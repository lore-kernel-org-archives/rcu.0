Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B1E25F7A4;
	Tue, 19 Aug 2025 15:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755618020; cv=none; b=Qzigbc6EMCTE9rLySvHjWXynTLmz/OA4UvThcT1BVamWKR76uADHFu6QWVYsJL9+3ynalyoSKCDKW+k8V2DT3tTglt0H/vD9MYpBDgoooUn6CGj7QTcWAQV1hb21rMXJZMU5x53fipYQcW7WQzlGFFZ1pVE3ELTzyDwtquxy+9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755618020; c=relaxed/simple;
	bh=eu6+uWSzQeXY4M0g9U4l/Ckhh9dAJmMP6fSnoQVnY+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rODbS4xaOBFg3zdTC7sK8E/WXkAQRnVedZNWAcZqYgN6a7Y6nUBjJcla9MbgIv+3m1P3TVy9Hv7RAeytwVEVrBBmQfkEgVhlR2DU+yPk0uHAjEW7VaKj2Ynj0fps4Lbehp+Brj4ZrFPSI+1gfHBGrhkCOmF6Saq0VDzKALk+J1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KXY2yodX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXY2yodX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0126DC4CEF1;
	Tue, 19 Aug 2025 15:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755618016;
	bh=eu6+uWSzQeXY4M0g9U4l/Ckhh9dAJmMP6fSnoQVnY+w=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=KXY2yodXly2/ITnui9/1ULmLi/irI8XaUdL4WUcQQqOmUd2UoSd3L8UxD6nqY0OGb
	 GBPZY8uElrPslfOGkX2QfI4c0JS7kcTvXptMpfyUQz+60L/IeSVjd4CKBjr4CfOC5p
	 SBViaqiOFzgDn2uDdHywpuxA4c6HjlJ85TSynCGsHK5yE0DUyenD6M2imxZbcRZ0c7
	 gne79rctHlu/aQh5HPzqZiillycnwfSAaa8H5VQC2GOlNZZ94P9dY/VA1otDnv0uxF
	 HQf5AxPYhhixusyNFoaas2F+cgEnxF2rY0R6g8f1LQRB/5FyQ1emvWtiDCfLKGWNV8
	 RkB8/xv2W+b+g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9F1F2CE0853; Tue, 19 Aug 2025 08:40:15 -0700 (PDT)
Date: Tue, 19 Aug 2025 08:40:15 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux RCU <rcu@vger.kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>, Zqiang <qiang.zhang@linux.dev>
Subject: Re: [PATCH] Documentation: RCU: Wrap kvm-remote.sh rerun snippet in
 literal code block
Message-ID: <3b5d4337-9e19-40b5-a8cb-021c6afab9a1@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250819004559.11429-1-bagasdotme@gmail.com>
 <f36daf4d-ed4b-4ac2-9932-10e46abdc109@infradead.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f36daf4d-ed4b-4ac2-9932-10e46abdc109@infradead.org>

On Mon, Aug 18, 2025 at 09:16:04PM -0700, Randy Dunlap wrote:
> 
> 
> On 8/18/25 5:45 PM, Bagas Sanjaya wrote:
> > Unlike other kvm*.sh snippets in RCU torture test documentation,
> > kvm-remote.sh rerun snippet isn't formatted as literal code block,
> > causing it to be definition list instead in htmldocs output.
> > 
> > Wrap it like the rest.
> > 
> > Fixes: 0c208a793022 ("doc: Update torture.rst")
> > Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> 
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thank you, and I will apply this on my next rebase.

> BTW, 20 lines above this change, the text says:
> 
>   If you the following command works::
> 
> Do you have any idea what word is missing there?
> or maybe Paul can make a suggestion.

I suggest dropping the "you".  In fact, I just created a commit with
your Reported-by doing just that.

Thank you, and now to find that brown paper bag...

							Thanx, Paul

> Thanks.
> 
> > ---
> >  Documentation/RCU/torture.rst | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/RCU/torture.rst b/Documentation/RCU/torture.rst
> > index 4b1f99c4181fee..cc57d01ed700ff 100644
> > --- a/Documentation/RCU/torture.rst
> > +++ b/Documentation/RCU/torture.rst
> > @@ -364,7 +364,7 @@ systems must come first.
> >  The kvm.sh ``--dryrun scenarios`` argument is useful for working out
> >  how many scenarios may be run in one batch across a group of systems.
> >  
> > -You can also re-run a previous remote run in a manner similar to kvm.sh:
> > +You can also re-run a previous remote run in a manner similar to kvm.sh::
> >  
> >  	kvm-remote.sh "system0 system1 system2 system3 system4 system5" \
> >  		tools/testing/selftests/rcutorture/res/2022.11.03-11.26.28-remote \
> > 
> > base-commit: 61399e0c5410567ef60cb1cda34cca42903842e3
> 
> -- 
> ~Randy
