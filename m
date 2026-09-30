Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3E150257A;
	Wed, 30 Sep 2026 20:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790798620; cv=none; b=daQ+kTSeeEAFWroub78RHO2qzlZCuKprhYZJetlzToPCqbwKGb7b4r3PmZII6aR7+N2dDRCkhTZNlY26Kva3DpEUMVG5MyX8z8CFgP3v6JRGu31Zb+W28H8kXNhorKiA3F0LG/yIrAF4yUT3I7zziwWBY/qgVuiXZHF9QehTDOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790798620; c=relaxed/simple;
	bh=R0Pst41HhG2IvhgiRRkCUs7PSC/Kra6AsKDoXn0iLeY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YBDYUPwPZ3prwvRX4mrTVJ/CFBKPz6zxzPYhiuHqCqjUFvGE06VBB+7l85730F9Eefj8Ga8eWNZzwaEv44pfZO0TqhdclWIFbC2IqPy6K9QLbgK7X7dD7w8dhZLKqlt1hQP6qp95z9ualxELy8p0k4+1Qr1ODfjc07JVlGt6uk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=MiJednfa; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="MiJednfa"
Received: from omf16.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 98EAEC0213;
	Wed, 30 Sep 2026 20:03:31 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 7110C2000E;
	Wed, 30 Sep 2026 20:03:28 +0000 (UTC)
Date: Wed, 30 Sep 2026 16:03:25 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, Frederic Weisbecker
 <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Josef Bacik
 <josef@toxicpanda.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH] fprobe: Use guard(rcu_sched_notrace) and check
 rcu_is_watching()
Message-ID: <20260930160325.3f2621ea@fedora>
In-Reply-To: <179064115227.394389.16910234241400391996.stgit@devnote2>
References: <179064115227.394389.16910234241400391996.stgit@devnote2>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 7110C2000E
X-Stat-Signature: qowj4mzi55d1sm8hduqohbs3j6mdmu8j
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18cYsQVpcBjgAYXBVM8qB3nAyzNdICfBuM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=Fk+ufLRG/5GSgAmLjNRTmOJUANq6vrEruXfSnAGQKTQ=; b=MiJednfacU61kjPuHeyKC6aujR8FJNE9nTxZs51Sb3KmnmxFp34bko0HBpgYuI6lZOkJv42kP2Q3/oPAICjwY0yp8Bs1l6t6Q8ibQ1aj69uXJgNhaNJZqnWR+XnTbMANBRxbB/m1YydWjyzzb9jW5J6xENlFacP27AV9spZuSB8=
X-HE-Tag: 1790798608-634585
X-HE-Meta: U2FsdGVkX1/zFXJt9T899aZAaewnheLNQhKaMqdk9WRZ2YlELs3vMaZCXGhOQJWTuwrD+qd9ouEZkTXhfmeR25a5ZqenupclLa6GP+iqUGu4FsGsR4ykhq4/kIGEvooxAI0M9zJ/ktpw7bXkMlaLMyFbP40MlWOQLCLcdGNZ2iPoZ/UjoThsew/JImUMZ8dEHsJAE3PbzAMfPAJb6MxezbQqV6Gfp5nDpPBPIVpavXPtNEzx9yJ5k4JEqQtV7ojDqNEQpiOneIiYnoQcMX9Tcs40hgmNByXKN/clgFVkpVC8Enw95I16BryYbHDp2wpKB4dcwe6kOoUCNN8ldaeMhSKnwuuL1hGSQ8BIJnn7Hhxbj2ZLDCYm0g==

On Tue, 29 Sep 2026 09:19:12 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> @@ -329,16 +333,14 @@ static void fprobe_ftrace_entry(unsigned long ip, unsigned long parent_ip,
>  	struct fprobe *fp;
>  	int bit;
>  
> +	if (!rcu_is_watching())
> +		return;
> +

I'm thinking these should really be:

	if (WARN_ON_ONCE(!rcu_is_watching()))
		return;

-- Steve
