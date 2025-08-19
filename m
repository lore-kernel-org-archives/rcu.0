Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DE038B;
	Tue, 19 Aug 2025 04:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755576970; cv=none; b=AuZM12q5pjXB7wywplG0IKzvA/8Fzuj4e7u05d4OZ8mOjzeTtH81HvKosb5QSmmrb9BTJ/cQsGez208BmhTas12wCrbFkBw+nl3n2rvu0iEyxvUd8Elbphvyj+/BrZs5h8zP8K8X37XXK8RovNzSlaZliIkQwboawEyEXKgqBNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755576970; c=relaxed/simple;
	bh=mMKWD0WJ0y9QEwCwbcOoeBt1IgYfCGCuNyoc6MTfx0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g1mQS4ayp4inZRH7yWRrcrcIfYH7/ITvvhB+qRNNeSuM6wxvL5rZ7bGrMbW09Oo6Vrnwyx6BDhDWdZDxFBXbZgBg9lYM9EP47MLRwf4WxGofAR8wHcHENK6cF6Ov0jFlOz4SWn4VcRSVxrUu0X6tX2WQNj1y47fiS3USBwqb+8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=h8ue8rx5; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h8ue8rx5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=19oxCXqS33NB+Ssjwi1gbteR7DOix9Rje35Ru1DY3sI=; b=h8ue8rx5qK+78YoY3+G1kobzpr
	snDiQ5CEVfNjNYwSUErMoAdqw5pcfOPReGnjzpctS8+Bved5Vv3fRVBREZtfDvTvGj2HWgJQLoY16
	k0nUovOH5rLeW8ghwcdrFsrWPjQyu4d6WhpvdsyPSVMrrX7M95SPUGjGTnRyJOGUJgpGYOg0LLGWc
	PjcyIGbDUEWWOZHaN38vTCfVl//1oQ8zLjgG6P97iqhfxbl3MVBdbsOYYBR/HB7ohm9XuQB+FR6Fd
	n/g+eFhpU9QRRoCIQr0Sglws1O99N+aPC+mUOGtw6oIy/9MZ1LE0Rt1Huqgzso83B0BJ3XtX/SuTQ
	qt3KbU5w==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoDlV-00000009MZW-0XHm;
	Tue, 19 Aug 2025 04:16:05 +0000
Message-ID: <f36daf4d-ed4b-4ac2-9932-10e46abdc109@infradead.org>
Date: Mon, 18 Aug 2025 21:16:04 -0700
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: RCU: Wrap kvm-remote.sh rerun snippet in
 literal code block
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux RCU <rcu@vger.kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>, "Paul E. McKenney"
 <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>,
 Jonathan Corbet <corbet@lwn.net>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Zqiang <qiang.zhang@linux.dev>
References: <20250819004559.11429-1-bagasdotme@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250819004559.11429-1-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/18/25 5:45 PM, Bagas Sanjaya wrote:
> Unlike other kvm*.sh snippets in RCU torture test documentation,
> kvm-remote.sh rerun snippet isn't formatted as literal code block,
> causing it to be definition list instead in htmldocs output.
> 
> Wrap it like the rest.
> 
> Fixes: 0c208a793022 ("doc: Update torture.rst")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

BTW, 20 lines above this change, the text says:

  If you the following command works::

Do you have any idea what word is missing there?
or maybe Paul can make a suggestion.

Thanks.

> ---
>  Documentation/RCU/torture.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/RCU/torture.rst b/Documentation/RCU/torture.rst
> index 4b1f99c4181fee..cc57d01ed700ff 100644
> --- a/Documentation/RCU/torture.rst
> +++ b/Documentation/RCU/torture.rst
> @@ -364,7 +364,7 @@ systems must come first.
>  The kvm.sh ``--dryrun scenarios`` argument is useful for working out
>  how many scenarios may be run in one batch across a group of systems.
>  
> -You can also re-run a previous remote run in a manner similar to kvm.sh:
> +You can also re-run a previous remote run in a manner similar to kvm.sh::
>  
>  	kvm-remote.sh "system0 system1 system2 system3 system4 system5" \
>  		tools/testing/selftests/rcutorture/res/2022.11.03-11.26.28-remote \
> 
> base-commit: 61399e0c5410567ef60cb1cda34cca42903842e3

-- 
~Randy
