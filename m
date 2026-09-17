Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0D74E73B0;
	Thu, 17 Sep 2026 20:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789677106; cv=none; b=s37v/MrYjc29FeUT4m+sUS3cXBBeeIfT5T+BrazsvN2g7HXV1yDwFExXeroNESB+iLfWvk+NCWB17TuLrHqii3vGK7HfqfACTgctJIIuwOZ+rPkOBQwo0/e/70/xFumo1fSVLttp641tUJ1OPj1WRtPP8+see/HfQW1HihYluPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789677106; c=relaxed/simple;
	bh=vcpJ74ZsKVFhAmNXcqmoG9+n/y5nCZi+8o+QaYEnJuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTpxX9iT+/F6XUVIJR5XJ4px9ei1xCy807iiK+r5EcT4AL/Cef1JqTR2tEgaHFRwZbv32A27B03vN6wZzFgIcsMDdMEPKwYTabQNaBYUfp7VaoCgBmbjD0u5953vyWQGGryj7Dtd022nBoek0mUBwB5+6joBSdjPGYVRTL81kUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ts3RaYNr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ts3RaYNr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F115D1F000FF;
	Thu, 17 Sep 2026 20:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789677105;
	bh=1DNCW5bB+cAYVy5PyJp5VUEN9k9DZzvAe3lm+iP5ciY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=Ts3RaYNrEkFulPAP4OS7uNGnQMm/6SzgIVeMh8NGZAkrMhOzleLAdfRvTZ6hDjBpn
	 sK3Xe4dOcnOhN9iirOMs0CB2GL2Z6qOI3aMMVN9pozJjUFCtPX2GsXChdiXAMvHv/H
	 A9ja+yO6aO4CuwpA4BPDb/njnc8+lhp17d7MAKl8dciFXjoqTpMKiBiwhuhirN0XzO
	 D1azThDi/j3Cf7bGLueAkZ9BywzCDXdnK4GG5oCv2G8CqZplWKkn8lYBpNwE7UR8ay
	 wI53qK8FbjQmzeKpADME9erclbbWiZVtKHS3EtpdnGGngJcrveU/fvURFyEGsddimA
	 W8zBwB4+X35YA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id AF6E2CE1771; Thu, 17 Sep 2026 13:31:44 -0700 (PDT)
Date: Thu, 17 Sep 2026 13:31:44 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Boqun Feng <boqun@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, x86@kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Andy Lutomirski <luto@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Juergen Gross <jgross@suse.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH RFC v3 03/13] rcu-tasks: Add a Tasks RCU implementation
 for reader-marked trampolines
Message-ID: <ef2cf89b-4cc6-4778-af91-6bb67fb10188@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <91687748-0781-4133-baed-43cf82f35ff5@paulmck-laptop>
 <aqqpRoTfywUuTgoC@localhost.localdomain>
 <aqqsAUVV8a1yrQzX@localhost.localdomain>
 <6afb0afe-e7b8-46b4-9fea-2c7cf4791044@paulmck-laptop>
 <aqq0cwvRDsorGwgc@localhost.localdomain>
 <8b73e1b3-0580-4ba9-b2e0-6363e429808d@paulmck-laptop>
 <aqvZwfUVsiEI7q7y@localhost.localdomain>
 <8fea176a-0ca0-4a70-8cf9-8240a22359e4@paulmck-laptop>
 <aqw1UNGO3cQxvCco@pavilion.home>
 <33b8e33a-3fad-4b33-9ae7-3948f0e6d3aa@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <33b8e33a-3fad-4b33-9ae7-3948f0e6d3aa@paulmck-laptop>

On Thu, Sep 17, 2026 at 12:25:40PM -0700, Paul E. McKenney wrote:
> On Thu, Sep 17, 2026 at 08:45:36PM +0200, Frederic Weisbecker wrote:
> > Le Thu, Sep 17, 2026 at 08:40:10AM -0700, Paul E. McKenney a écrit :
> > > > > Trampolines that transfer control to tracing code could supply the needed
> > > > > cleanup call.  But last I checked, there were trampolines that transferred
> > > > > directly back to the original code, with no opportunity for cleaning up.
> > > > > 
> > > > > Or am I still missing a trick here?
> > > > 
> > > > You're right. So we'll indeed need to reuse the deferred qs points here.
> > > 
> > > Except this is getting a bit involved.
> > > 
> > > Don't get me wrong, if Josef is happy to take this on, far be it from me
> > > to stand in his way.  But if not, we should be willing to treat this
> > > optimization as a follow-on effort, whether by Josef or someone else.
> > 
> > Sure, I guess I can try the follow-on, especially if it leads to removing
> > all this RCU tasks black magic.
> 
> That sounds most excellent, thank you!

Ah, and in case anyone (especially Josef) is wondering, one big advantage
of the more elaborate approach is that it allowed the real-time guys to
avoid yet another source of IPIs messing with their latencies.

							Thanx, Paul
