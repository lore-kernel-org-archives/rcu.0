Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2984F128372;
	Mon,  6 May 2024 10:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714992536; cv=none; b=cFv/ioCuwoJLqoZOlnxr7J+DXp9YmaQIWdTKtAtnk/aMRdvpR6MuujuAPyyUNvVNGNg9y3CbUpnOr1Dq77TL/Kr/mRm8UQ8sxZXfoem42I69wfDFYwG03GKoJMeR6/BxRP1W0lIZNBtb7+yMTmKF0wT3ykPXQRPkF4TiUX1TZZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714992536; c=relaxed/simple;
	bh=zKUXnO7Pk1vh1mfhbmxV+aR2BrGJ0AO3JRylRIvlojs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OAeKqq1rYgp/9IX1JRKXRdk2P8uc/G9Z3niA56og8c0ODijqrbZMblojucW3z4W3SgFICI1/OloZ8fuT7WQiFHz1TXyGEAPZPwt0riccwCP1u1HWySuZq03wsvizdmKkDnBEgM1cMaFe/XxxyRUm/pUgNyiBkTuLG+eQ0aTsBxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dPc3Gb40; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dPc3Gb40"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F79C116B1;
	Mon,  6 May 2024 10:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714992535;
	bh=zKUXnO7Pk1vh1mfhbmxV+aR2BrGJ0AO3JRylRIvlojs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dPc3Gb401b+yTwA2oykq0GCkkle5whTKh//QMcYn1mldaUxIFvjIx331X9MIN6TJJ
	 gV+rEk2J6TtbshQ/hIOFx4ywoKoqAFxI2Esp+iEyKAxfTQrcGC9tt/+s+pc6PAP6eL
	 f+e4dFhAPt9R1ZJgYaQddSFjblThGo8++dqfprlatb9E2bnCE8RdrnQrLaQAfGAq8v
	 WrnnGzvD+bKV32qIql2nKpGmnoFtPbX7+i5kuCpoJQdz6iyJGioLdNVGVGzAL0MzlK
	 DM9lf5WPWj+nzFDD9ePNlZf8VciF/i8xnUOdWCtKXJ9r94DwIKAmLRq3LfISerlSPB
	 EBgOUz2YxEvCw==
Date: Mon, 6 May 2024 12:48:53 +0200
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
Subject: Re: [PATCH v2 06/27] context_tracking, rcu: Rename struct
 context_tracking .dynticks_nesting into .nesting
Message-ID: <Zji1lXBJJOiwEvN8@localhost.localdomain>
References: <20240430091740.1826862-1-vschneid@redhat.com>
 <20240430091740.1826862-7-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240430091740.1826862-7-vschneid@redhat.com>

Le Tue, Apr 30, 2024 at 11:17:10AM +0200, Valentin Schneider a écrit :
> The context_tracking.state RCU_DYNTICKS subvariable has been renamed to
> RCU_WATCHING, reflect that change in the related helpers.
> 
> Suggested-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
