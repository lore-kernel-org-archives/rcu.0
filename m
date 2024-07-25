Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069051428E5;
	Thu, 25 Jul 2024 12:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721910442; cv=none; b=cr4CVLMmEu5nZTXm/8+Ot77huZYXOGAhYlwVX9wlfvlf5GZsJF0T/En8Qt+6wtWIarT/x2Kv5cTqEl07vYLHTY75NLue8hEwlRB4u32rZvFSu6Ej8ixXERUrJVXxa4jwchDTleW7HudT0fxZTVIPuRxXf/YMmvq1R4640X5rEZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721910442; c=relaxed/simple;
	bh=/ZuJY8/qXUR8TY+MFLL7+3PJfKaL0XQ6IMLMm67nFW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ph72RYOPDFRIxHC31qLgPwc5q3Nd5/6usph58dPSU1kvUMGn1V7rQmCMb4r8MFW32Ms2qr4H3tnXUeZ8tO15Dlw8ds5AzOkvdG3lJ6/qT5IDZpPmMzTQbI1CSGFyl7LAHiR0wR2Yms6AhnrtRuwQnjljzlguNodfUwIDYyqdvzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FoHzsbi2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FoHzsbi2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A967C116B1;
	Thu, 25 Jul 2024 12:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721910441;
	bh=/ZuJY8/qXUR8TY+MFLL7+3PJfKaL0XQ6IMLMm67nFW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FoHzsbi2vsp0vvmNnY8HT+3p6NElOL1lRek6zwtIndNQWcIj+1+tCFNqlD9otkGx4
	 PBGfVHPUDc+u5jryNJYZVJRsp29Ak61U+XQsiBTQkLloaJi8SrmGLFHktxkkYioloz
	 s8BKI4jZtJ0rAXuFPhnySgKSh77oFJcExAjlytTOtGHk7xbr9aeRPQEk0Vnu4T1Ktc
	 UaQwyp9NRFFqp3FV7RXk4/3JOhZavf1UghJkYnVr6FrJFG1kVWIsEg36Uo8Ar3U4I6
	 vYmLK8V4ZcA4TyXYrKBTYNFFoOcCUkbqqCqda81ZNssbBSUYfCeIZWHsBRtH7lY3h5
	 qxH4PcS1rkEyA==
Date: Thu, 25 Jul 2024 14:27:19 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH v3 22/25] rcu: Rename rcu_implicit_dynticks_qs() into
 rcu_implicit_eqs()
Message-ID: <ZqJEpy1D5LZA6fgi@localhost.localdomain>
References: <20240724144325.3307148-1-vschneid@redhat.com>
 <20240724144325.3307148-23-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240724144325.3307148-23-vschneid@redhat.com>

Le Wed, Jul 24, 2024 at 04:43:22PM +0200, Valentin Schneider a écrit :
> The context_tracking.state RCU_DYNTICKS subvariable has been renamed to
> RCU_WATCHING, replace "dynticks_qs" into "eqs" to drop the dyntick
> reference.
> 
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>

You'll need to update the patch title and changelog for this one.
Other than that:

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
