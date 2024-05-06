Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F0C142E62;
	Mon,  6 May 2024 10:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714992335; cv=none; b=XXAxZW/TBkXOsCTfK69XxcNuLN+XYqItjSDuwmlNqFR7BsLo9fgS5k9+x3BGps2LQjkuLIhApAPZeqvXqMyhXhithv3Nczd1+PTgk9bfhuX+fbh5sX/ZNXkOJCYZ+9Xc3OM02Vcxyv/FtJ6Ta23mtu0wwFyk68rspPXfwxEdtKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714992335; c=relaxed/simple;
	bh=ZEo8VfPRy4Zbb8XO7sOaI+O6hXHTMeRWbsoGYyVxIE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CFH1A3Qy3BdDzZH7tt6wf81tq/lap/D5XAfeA4nydhmeYF6OHCOudkbVbOFsmcyqiW9fTpqihyekTPY9Tv80fHwnB8WWyoegeCS/NXaEFSCjOXFvtyo8npTZqvt+dBcIlr9EAKDW/LOvnkIJeln0vgGeOLC69+VHZt8mvodH6vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YlTbhwEW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YlTbhwEW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7135C4AF66;
	Mon,  6 May 2024 10:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714992335;
	bh=ZEo8VfPRy4Zbb8XO7sOaI+O6hXHTMeRWbsoGYyVxIE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YlTbhwEWBY6/XOwM9DKunUSTLrM3hp97bfwMVeVl4Rf/wKdQzQdc0vsKcX45uvzHV
	 7ASUuySmQpiWkVpDGsZN+YeRRyI686TN4om9cJnJOOPydK1ZC7pmfanChYUX0vxyGR
	 rrUwwp9qno39Eta3we4kQBAdvlWnVcVJryownI41U+rpaOIqzklARrn6HI6KjOJ9AO
	 VH+ZsUtiA07gX7bUAFmfFd8ITRf46RjUw7Rg+AvK7tGOWM9p1xKkeOD4fLzrCoeTzk
	 zhMom0MQkeek780abb4X9A1Nz/pQrtUcIJlYnlD74cu5rlrE2N7CYJcESTggRYNyT5
	 FMcnIL6WMN+Kg==
Date: Mon, 6 May 2024 12:45:32 +0200
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
Subject: Re: [PATCH v2 05/27] context_tracking, rcu: Rename
 ct_dynticks_cpu_acquire() into ct_rcu_watching_cpu_acquire()
Message-ID: <Zji0zDxHVwuRlV78@localhost.localdomain>
References: <20240430091740.1826862-1-vschneid@redhat.com>
 <20240430091740.1826862-6-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240430091740.1826862-6-vschneid@redhat.com>

Le Tue, Apr 30, 2024 at 11:17:09AM +0200, Valentin Schneider a écrit :
> The context_tracking.state RCU_DYNTICKS subvariable has been renamed to
> RCU_WATCHING, reflect that change in the related helpers.
> 
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
